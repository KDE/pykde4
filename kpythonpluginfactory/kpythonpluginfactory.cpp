/* copyright 2003 Jim Bublitz <jbublitz@nwinternet.com>
   copyright 2008 Simon Edwards <simon@simonzone.com>
   
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

#include <QFileInfo>
#include <QDir>
#include <klibloader.h>
#include <kstandarddirs.h>
#include <kcmodule.h>
#include <Python.h>

class KPythonPluginFactory : public KPluginFactory
{
    public:
        KPythonPluginFactory(const char *name=0);
        ~KPythonPluginFactory();

    protected:
        virtual QObject *create(const char *iface, QWidget *parentWidget, QObject *parent, const QVariantList &args, const QString &keyword);
    private:
        void initialize();
        bool appendToSysPath (QString newPath);
        PyObject *importModule (QString moduleName);
        PyObject *runFunction(PyObject *object, PyObject *args);
        QLibrary *pythonLib;
};
K_EXPORT_PLUGIN(KPythonPluginFactory("kpythonpluginfactory"))
K_GLOBAL_STATIC(KComponentData, KPythonPluginFactory_factorycomponentdata)

KPythonPluginFactory::KPythonPluginFactory(const char *name) : KPluginFactory(name)
{
    pythonLib = 0;
    printf("KPythonPluginFactory::KPythonPluginFactory()\n");
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
        // Reload libpython, but this time tell the runtime linker to make the
        // symbols global and available for later loaded libraries/module.
        pythonLib = new QLibrary();
        pythonLib->setLoadHints(QLibrary::ExportExternalSymbolsHint);
        pythonLib->setFileName(LIB_PYTHON);
        pythonLib->load();

        PyEval_InitThreads ();
        Py_Initialize ();
        if (!Py_IsInitialized ())
        {
            //pythonInit = 0;
            return;
        }

        printf ("Python interpreter initialized!\n\n");

        // free the lock
        PyEval_ReleaseLock();
    }
}

QObject *KPythonPluginFactory::create(const char *iface, QWidget *parentWidget, QObject *parent, const QVariantList &args, const QString &keyword)
{
    initialize();
    printf("KPythonPluginFactory::create iface: %s\n",iface);
    printf("keyword: %s\n",(char *)keyword.toLatin1().data());
    QString completePath = KStandardDirs::locate("data", keyword);
    printf("keyword path: %s\n",(char *)completePath.toLatin1().data());
    if (completePath.isEmpty())
    {
        printf("*** Unable to find script: %s\n",(char *)keyword.toLatin1().data());
        return 0;
    }
    
    printf("args: %i\n",args.count());
    
    QFileInfo pathInfo(completePath);
    QString path = pathInfo.absoluteDir().absolutePath();
    QString scriptName = pathInfo.baseName();
printf("module path is %s\n",(char *)path.toLatin1().data());

    // Set up the Python module path.
    if(!appendToSysPath(path.toLatin1().data()))
    {
        printf("*** Failed to set sys.path with %s\n",(char *)path.toLatin1().data());
        return 0;
    }
    
    // Load the Python script.
    PyObject *pyModule = importModule(scriptName);
    if(!pyModule)
    {
        PyErr_Print();
        printf("*** failed to import module\n");
        return 0;
    }

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
printf("bridge: %s\n",(char *)bridge.toLatin1().data());

    PyRun_String(bridge.toLatin1().data(), Py_file_input, PyModule_GetDict(pyModule), PyModule_GetDict(pyModule));

    // Get the Python module's factory function.
    PyObject *factoryFunction = PyObject_GetAttrString(pyModule, "kpythonpluginfactory_bridge");
    if(!factoryFunction)
    {
        printf("***failed to find factory function\n");
        return 0;
    }

    registerPlugin<KCModule>(keyword,0);//,&QObject::staticMetaObject,0);
    
    // Call the factory function. Set up the args.
    PyObject *pyParentWidget = PyLong_FromVoidPtr(parentWidget);
    PyObject *pyParent = PyLong_FromVoidPtr(parent);
    PyObject *pyComponentData = PyLong_FromVoidPtr(KPythonPluginFactory_factorycomponentdata);
    
/*
KComponentData kd = KPythonPluginFactory::componentData();
    printf("kd is value(): %i\n",(int)kd.isValid());
    kd = componentData();
    printf("kd2 is value(): %i\n",(int)kd.isValid());
*/
    printf("kd1 is valid(): %i\n",(int)KPythonPluginFactory_factorycomponentdata->isValid());

    // Using NNN here is effect gives our references to the arguement away.
    PyObject *functionArgs = Py_BuildValue ("NNN", pyParentWidget, pyParent, pyComponentData);
    PyObject *pyResultTuple = 0;
    if(pyParentWidget && pyParent && functionArgs)
    {
        // run the factory function
        pyResultTuple = runFunction(factoryFunction, functionArgs);
        if(!pyResultTuple)
        {
            printf("*** runFunction failure\n;");
            PyErr_Print();
            return 0;
        }
    }
    else
    {
        printf("***failed to create args\n");
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
        printf("***failed sip conversion to C++ pointer\n");
        return 0;
    }
    Py_XDECREF(pyResultTuple);
    
    // PyKDE can't run the module without this - Pythonize
    // grabs the lock at initialization and we have to give
    // it back before exiting. At this point, we no longer need
    // it.
    //pyize->releaseLock ();

    // take care of any translation info
//    KGlobal::locale()->insertCatalogue(script);
    printf("returning result qobject\n");
    return resultQObject;
}

KPythonPluginFactory::~KPythonPluginFactory()
{
    printf("KPythonPluginFactory::~KPythonPluginFactory()\n");
    if (Py_IsInitialized())
    {
        Py_Finalize();
    }
    if (pythonLib)
    {
        delete pythonLib;
    }
}

bool KPythonPluginFactory::appendToSysPath (QString newPath)
{
    if (newPath.isEmpty()) return false;

    QString line = QString("import sys\nif not '%1' in sys.path:\n\tsys.path.append ('%2')\n")
                           .arg(newPath).arg(newPath);
    printf("load line: %s\n",(char *)line.toLatin1().data());

    int res = PyRun_SimpleString (line.toLatin1().data());
    return res == 0;
}

PyObject *KPythonPluginFactory::importModule (QString moduleName)
{
    if (moduleName.isEmpty()) return 0;

    PyObject *module = PyImport_ImportModule (moduleName.toLatin1().data());

    //objects = new ObjectRef (objects, module);
    //if (!objects) return NULL;

    return module;
}

PyObject *KPythonPluginFactory::runFunction(PyObject *object, PyObject *args)
{
    if (!PyCallable_Check (object))
        return NULL;

    PyObject *res = PyObject_CallObject (object, args ? args : PyTuple_New (0));
    Py_XINCREF (res);

    return res;
}
