/* Copyright 2003 Jim Bublitz <jbublitz@nwinternet.com>
   Copyright 2008 Simon Edwards <simon@simonzone.com>
   Copyright 2008 David Boddie <david@boddie.org.uk>

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public License
   along with this library; see the file COPYING.LIB.  If not, write to
   the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.
*/

#include <QtCore/QCoreApplication>
#include <QFileInfo>
#include <QDir>
#include <QSet>
#include <klibloader.h>
#include <kstandarddirs.h>
#include <kcmodule.h>
#include <Python.h>
#include <kcomponentdata.h>
#include <kdebug.h>

/*
This implements a plugin factory for running Python plugins. It also
supports io-slaves with a kdemain() entry point.
*/

class KPythonPluginFactory : public KPluginFactory
{
    public:
        KPythonPluginFactory(const char *name=0);
        ~KPythonPluginFactory();

    protected:
        virtual QObject *create(const char *iface, QWidget *parentWidget, QObject *parent, const QVariantList &args, const QString &keyword);
    private:
        void initialize();
        QLibrary *pythonLib;
        static QSet<QString> loadedKeywords;
};
QSet<QString> KPythonPluginFactory::loadedKeywords;

K_EXPORT_PLUGIN(KPythonPluginFactory("kpythonpluginfactory"))
K_GLOBAL_STATIC(KComponentData, KPythonPluginFactory_factorycomponentdata)

bool AppendToSysPath (QString newPath);
PyObject *ImportModule (QString moduleName);
QLibrary *LoadPythonLibrary();
PyObject *RunFunction(PyObject *object, PyObject *args);

// This cleanup function is run just before program unload but before
// any static data is destroyed. It makes sure that the interpreter
// is shutdown before the PyQt shared libraries etc are unloaded.
static void KPythonPluginFactoryCleanup_PostRoutine()
{
    if (Py_IsInitialized())
    {
        Py_Finalize();
    }
}

KPythonPluginFactory::KPythonPluginFactory(const char *name) : KPluginFactory(name)
{
    pythonLib = 0;

    kDebug() << "KPythonPluginFactory::KPythonPluginFactory()";

    qAddPostRoutine(KPythonPluginFactoryCleanup_PostRoutine);

    if (KPythonPluginFactory_factorycomponentdata->isValid())
    {
        setComponentData(*KPythonPluginFactory_factorycomponentdata); \
    }
    else
    {
        *KPythonPluginFactory_factorycomponentdata = KPluginFactory::componentData();
    }
}

void KPythonPluginFactory::initialize()
{
   if (!Py_IsInitialized ())
   {
        kDebug() << "Initializing Python interpreter.";
        pythonLib = LoadPythonLibrary();

        PyEval_InitThreads ();
        Py_Initialize ();
        if (!Py_IsInitialized ())
        {
            //pythonInit = 0;
            return;
        }

        kDebug() << "Succesfully initialized Python interpreter.";

        // free the lock
        PyEval_ReleaseLock();
    }
}

QObject *KPythonPluginFactory::create(const char *iface, QWidget *parentWidget, QObject *parent, const QVariantList &args, const QString &keyword)
{
    initialize();

    kDebug() << "KPythonPluginFactory::create iface: " << iface;
    kDebug() << "keyword to be used for finding the plugin code: " << keyword;
    QString completePath = KStandardDirs::locate("data", keyword);
    kDebug() << "Path to plugin code is: " << completePath;

    if (completePath.isEmpty())
    {
        kError() << "Unable to find plugin code: " << keyword;
        return 0;
    }
    
    QFileInfo pathInfo(completePath);
    QString path = pathInfo.absoluteDir().absolutePath();
    QString scriptName = pathInfo.baseName();

    bool loaded = loadedKeywords.contains(keyword);

    // Set up the Python module path.
    if (!loaded)
    {
        if(!AppendToSysPath(path.toLatin1().data()))
        {
            kError() << "Failed to set sys.path to " << path;
            return 0;
        }
    }    

    // Load the Python script.
    PyObject *pyModule = ImportModule(scriptName);
    if(!pyModule)
    {
        kError() << "Failed to import module";
        PyErr_Print();
        return 0;
    }


    if (!loaded) {
        // Inject a helper function
        QString bridge = QString("def kpythonpluginfactory_bridge(parentWidget,parent,componentData):\n"
                                "    import sip\n"
                                "    from PyQt4 import QtCore\n"
                                "    from PyQt4 import QtGui\n"
                                "    from PyKDE4 import kdecore\n"
                                "    if parentWidget!=0:\n"
                                "        wparentWidget = sip.wrapinstance(parent,QtGui.QWidget)\n"
                                "    else:\n"
                                "        wparentWidget = None\n"
                                "    if parent!=0:\n"
                                "        wparent = sip.wrapinstance(parent,QtCore.QObject)\n"
                                "    else:\n"
                                "        wparent = None\n"
                                "    if componentData!=0:\n"
                                "        wcomponentData = sip.wrapinstance(componentData,kdecore.KComponentData)\n"
                                "    else:\n"
                                "        wcomponentData = None\n"
                                "    inst = CreatePlugin(wparentWidget,wparent,wcomponentData)\n"
                                "    return (inst,sip.unwrapinstance(inst))\n");
        PyRun_String(bridge.toLatin1().data(), Py_file_input, PyModule_GetDict(pyModule), PyModule_GetDict(pyModule));
    }

    // Get the Python module's factory function.
    PyObject *factoryFunction = PyObject_GetAttrString(pyModule, "kpythonpluginfactory_bridge");
    if(!factoryFunction)
    {
        kDebug() << "Failed to find factory function";
        return 0;
    }

    if (!loaded)
    {
        registerPlugin<KCModule>(keyword,0);//,&QObject::staticMetaObject,0);
    }
    
    loadedKeywords << keyword;

    // Call the factory function. Set up the args.
    PyObject *pyParentWidget = PyLong_FromVoidPtr(parentWidget);
    PyObject *pyParent = PyLong_FromVoidPtr(parent);
    PyObject *pyComponentData = PyLong_FromVoidPtr(KPythonPluginFactory_factorycomponentdata);

    // Using NNN here is effect gives our references to the arguement away.
    PyObject *functionArgs = Py_BuildValue ("NNN", pyParentWidget, pyParent, pyComponentData);
    PyObject *pyResultTuple = 0;
    if(pyParentWidget && pyParent && functionArgs)
    {
        // run the factory function
        pyResultTuple = RunFunction(factoryFunction, functionArgs);
        if(!pyResultTuple)
        {
            kError() << "Error while running factory function for Python plugin: " << keyword;
            PyErr_Print();
            return 0;
        }
    }
    else
    {
        kError() << "Failed to create args.";
        return 0;
    }
    // cleanup a bit
    Py_XDECREF(functionArgs);
    Py_XDECREF(factoryFunction);
    
    // Stop this from getting garbage collected.
    Py_INCREF(PyTuple_GET_ITEM(pyResultTuple,0));
    
    // convert the KCModule PyObject to a real C++ KCModule *.
    PyObject *pyQObject;
    pyQObject = PyTuple_GET_ITEM(pyResultTuple,1);
    QObject *resultQObject = (QObject *)PyLong_AsVoidPtr(pyQObject);
    if(!resultQObject)
    {
        kError() << "Failed sip conversion to C++ pointer";
        return 0;
    }
    Py_XDECREF(pyResultTuple);
    
    // take care of any translation info
//    KGlobal::locale()->insertCatalogue(script);
    kDebug() << "Returning result qobject";
    return resultQObject;
}

KPythonPluginFactory::~KPythonPluginFactory()
{
    kDebug() << "KPythonPluginFactory::~KPythonPluginFactory()";
    if (Py_IsInitialized())
    {
        Py_Finalize();
    }
    if (pythonLib)
    {
        delete pythonLib;
    }
}

bool AppendToSysPath (QString newPath)
{
    if (newPath.isEmpty())
    {
        return false;
    }

    QString line = QString("import sys\nif not '%1' in sys.path:\n\tsys.path.append ('%2')\n")
                           .arg(newPath).arg(newPath);
    return PyRun_SimpleString (line.toLatin1().data()) == 0;
}

PyObject *ImportModule (QString moduleName)
{
    if (moduleName.isEmpty())
    {
        return 0;
    }

    PyObject *module = PyImport_ImportModule (moduleName.toLatin1().data());
    return module;
}

// Reload libpython, but this time tell the runtime linker to make the
// symbols global and available for later loaded libraries/module.
QLibrary *LoadPythonLibrary()
{
    QLibrary *pythonLib = new QLibrary();
    pythonLib->setLoadHints(QLibrary::ExportExternalSymbolsHint);
    pythonLib->setFileName(LIB_PYTHON);
    pythonLib->load();
    return pythonLib;
}

PyObject *RunFunction(PyObject *object, PyObject *args)
{
    if (!PyCallable_Check (object))
    {
        return NULL;
    }

    PyObject *res = PyObject_CallObject (object, args ? args : PyTuple_New (0));
    Py_XINCREF (res);
    return res;
}

extern "C"
{
/*
The main function initializes the Python interpreter, if not already
running, imports the Python module containing the kioslave class to
use, and calls the kdemain() function in module with the pool and app
parameters. The Python kdemain code will typically do this:

    def kdemain(pool, app):
        slave = SlaveClass(pool, app)
        slave.dispatchLoop()
*/
int kdemain( int argc, char **argv )
{
    Q_UNUSED(argc);
    PyObject *pModule;
    char *protocol = argv[1];

    kDebug() << "Python kioslave starting";
    KComponentData slave(protocol);
    kDebug() << "Created KComponentData for protocol " << protocol;

    QLibrary *pyLib = LoadPythonLibrary();

    Py_SetProgramName(argv[0]);
    Py_Initialize();

    //PyEval_InitThreads();
    PySys_SetArgv(1, argv);

    QString completePath = KStandardDirs::locate("data", QString("kio_python/%1/%2.py").arg(protocol).arg(protocol));
    kDebug() << "Path to Python kioslace is " << completePath;
    QFileInfo pathInfo(completePath);
    QString path = pathInfo.absoluteDir().absolutePath();

    // Set up the Python module path.
    if(!AppendToSysPath(path.toLatin1().data()))
    {
        kError() << "Failed to set sys.path to " << path;
        return 1;
    }

    pModule = ImportModule(QString(protocol));
    if (pModule == NULL)
    {
        kError() << "Python kioslace module is NULL.";
        PyErr_Print();
        return 1;
    }

    // Get the Python module's kdemain function and call it.
    PyObject *factoryFunction = PyObject_GetAttrString(pModule, "kdemain");
    if(!factoryFunction)
    {
        kError() << "Failed to find factory function";
        return 1;
    }
    PyObject *pClass, *pArgs, *pArg1, *pArg2;
    pArgs = PyTuple_New(2);
    pArg1 = PyString_FromString(argv[2]);
    pArg2 = PyString_FromString(argv[3]);
    PyTuple_SetItem(pArgs, 0, pArg1);
    PyTuple_SetItem(pArgs, 1, pArg2);
    RunFunction(factoryFunction, pArgs);
    
    Py_XDECREF(pClass);
    Py_XDECREF(pArgs);
    Py_XDECREF(pModule);
    
    Py_Finalize();
    return 0;
}
}
