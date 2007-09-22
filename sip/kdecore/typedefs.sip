// Various typedefs

// PyKDE requires these
typedef uint mode_t;
typedef long time_t;
typedef ulong size_t;
typedef int ssize_t;
typedef int pid_t;
typedef ulong Window;
typedef bool Bool;
typedef uint WFlags;
typedef long off_t;
//typedef signed char qint8;
//typedef unsigned char quint8;
//typedef short qint16;
//typedef unsigned short quint16;
//typedef int qint32;
//typedef unsigned int quint32;
//typedef long long qint64;
//typedef unsigned long long quint64;

//typedef qint64 qlonglong;
//typedef quint64 qulonglong;

typedef uint uid_t;
typedef uint gid_t;

template<TYPE1, TYPE2*>
%MappedType QMap<TYPE1, TYPE2*>
//return a Python dict of TYPE1:TYPE2
{
%TypeHeaderCode
#include <qmap.h>
%End

%ConvertFromTypeCode
    // Create the dictionary.
    PyObject *d = PyDict_New();

    if (!d)
        return NULL;

    // Set the dictionary elements.
    QMap<TYPE1, TYPE2>::const_iterator i = sipCpp->constBegin();

    while (i != sipCpp->constEnd())
    {
        TYPE1 *t1 = new TYPE1(i.key());
        TYPE2 *t2 = new TYPE2(i.value());

        PyObject *t1obj = sipConvertFromNewInstance(t1, sipClass_TYPE1, sipTransferObj);
        PyObject *t2obj = sipConvertFromNewInstance(t2, sipClass_TYPE2, sipTransferObj);

        if (t1obj == NULL || t2obj == NULL || PyDict_SetItem(d, t1obj, t2obj) < 0)
        {
            Py_DECREF(d);

            if (t1obj)
                Py_DECREF(t1obj);
            else
                delete t1;

            if (t2obj)
                Py_DECREF(t2obj);
            else
                delete t2;

            return NULL;
        }

        Py_DECREF(t1obj);
        Py_DECREF(t2obj);

        ++i;
    }

    return d;
%End

%ConvertToTypeCode
    PyObject *t1obj, *t2obj;
#if PY_VERSION_HEX >= 0x02050000
    Py_ssize_t i = 0;
#else
    int i = 0;
#endif

    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyDict_Check(sipPy))
            return 0;

        while (PyDict_Next(sipPy, &i, &t1obj, *t2obj))
        {
            if (!sipCanConvertToInstance(t1obj, sipClass_TYPE1, SIP_NOT_NONE))
                return 0;

            if (!sipCanConvertToInstance(t2obj, sipClass_TYPE2, SIP_NOT_NONE))
                return 0;
        } 

        return 1;
    }

    QMap<TYPE1, TYPE2*> *qm = new QMap<TYPE1, TYPE2*>;
 
    while (PyDict_Next(sipPy, &i, &t1obj, &t2obj))
    {
        int state1, state2;

        TYPE1 *t1 = reinterpret_cast<TYPE1 *>(sipConvertToInstance(t1obj, sipClass_TYPE1, sipTransferObj, SIP_NOT_NONE, &state1, sipIsErr));
        TYPE2 *t2 = reinterpret_cast<TYPE2 *>(sipConvertToInstance(t2obj, sipClass_TYPE2, sipTransferObj, SIP_NOT_NONE, &state2, sipIsErr));
 
        if (*sipIsErr)
        {
            sipReleaseInstance(t1, sipClass_TYPE1, state1);
            sipReleaseInstance(t2, sipClass_TYPE2, state2);

            delete qm;
            return 0;
        }

        qm->insert(*t1, t2);

        sipReleaseInstance(t1, sipClass_TYPE1, state1);
        sipReleaseInstance(t2, sipClass_TYPE2, state2);
    }
 
    *sipCppPtr = qm;
 
    return sipGetState(sipTransferObj);
%End
};

template<TYPE>
%MappedType KSharedPtr<TYPE>
//converts KSharedPtr
{
%TypeHeaderCode
#include <ksharedptr.h>
%End

%ConvertFromTypeCode
    // Convert to a Python instance

    if (!sipCpp)
        return NULL;

    KSharedPtr<TYPE> *cPtr = new KSharedPtr<TYPE> (*(KSharedPtr<TYPE> *)sipCpp);
    TYPE *cpp = cPtr->data ();
    PyObject *obj = sipConvertFromInstance (cpp, sipClass_TYPE, sipTransferObj);

    return obj;
%End

%ConvertToTypeCode
    // Convert a Python instance to a Ptr on the heap.

    if (sipIsErr == NULL)
        return PyInstance_Check(sipPy);

    int iserr = 0;
    TYPE *cpp = (TYPE *)sipForceConvertTo_TYPE (sipPy, &iserr);

    if (iserr)
    {
        *sipIsErr = 1;
        return 0;
    }

    *sipCppPtr = new KSharedPtr<TYPE> (cpp);

    return 1;
%End
};


template<TYPE1, TYPE2>
%MappedType QHash<TYPE1, TYPE2>
//return a Python dict of TYPE1:TYPE2
{
%TypeHeaderCode
#include <qhash.h>
%End

%ConvertFromTypeCode
    // Create the dictionary.
    PyObject *d = PyDict_New();

    if (!d)
        return NULL;

    // Set the dictionary elements.
    QHash<TYPE1, TYPE2>::const_iterator i = sipCpp->constBegin();

    while (i != sipCpp->constEnd())
    {
        TYPE1 *t1 = new TYPE1(i.key());
        TYPE2 *t2 = new TYPE2(i.value());

        PyObject *t1obj = sipConvertFromNewInstance(t1, sipClass_TYPE1, sipTransferObj);
        PyObject *t2obj = sipConvertFromNewInstance(t2, sipClass_TYPE2, sipTransferObj);

        if (t1obj == NULL || t2obj == NULL || PyDict_SetItem(d, t1obj, t2obj) < 0)
        {
            Py_DECREF(d);

            if (t1obj)
                Py_DECREF(t1obj);
            else
                delete t1;

            if (t2obj)
                Py_DECREF(t2obj);
            else
                delete t2;

            return NULL;
        }

        Py_DECREF(t1obj);
        Py_DECREF(t2obj);

        ++i;
    }

    return d;
%End

%ConvertToTypeCode
    PyObject *t1obj, *t2obj;
#if PY_VERSION_HEX >= 0x02050000
    Py_ssize_t i = 0;
#else
    int i = 0;
#endif

    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyDict_Check(sipPy))
            return 0;

        while (PyDict_Next(sipPy, &i, &t1obj, &t2obj))
        {
            if (!sipCanConvertToInstance(t1obj, sipClass_TYPE1, SIP_NOT_NONE))
                return 0;

            if (!sipCanConvertToInstance(t2obj, sipClass_TYPE2, SIP_NOT_NONE))
                return 0;
        } 

        return 1;
    }

    QHash<TYPE1, TYPE2> *qm = new QHash<TYPE1, TYPE2>;
 
    while (PyDict_Next(sipPy, &i, &t1obj, &t2obj))
    {
        int state1, state2;

        TYPE1 *t1 = reinterpret_cast<TYPE1 *>(sipConvertToInstance(t1obj, sipClass_TYPE1, sipTransferObj, SIP_NOT_NONE, &state1, sipIsErr));
        TYPE2 *t2 = reinterpret_cast<TYPE2 *>(sipConvertToInstance(t2obj, sipClass_TYPE2, sipTransferObj, SIP_NOT_NONE, &state2, sipIsErr));
 
        if (*sipIsErr)
        {
            sipReleaseInstance(t1, sipClass_TYPE1, state1);
            sipReleaseInstance(t2, sipClass_TYPE2, state2);

            delete qm;
            return 0;
        }

        qm->insert(*t1, *t2);

        sipReleaseInstance(t1, sipClass_TYPE1, state1);
        sipReleaseInstance(t2, sipClass_TYPE2, state2);
    }
 
    *sipCppPtr = qm;
 
    return sipGetState(sipTransferObj);
%End
};


template<TYPE1, TYPE2*>
%MappedType QHash<TYPE1, TYPE2*>
//returns a Python dict of TYPE1:TYPE2
{
%TypeHeaderCode
#include <qhash.h>
%End

%ConvertFromTypeCode
    // Create the dictionary.
    PyObject *d = PyDict_New();

    if (!d)
        return NULL;

    // Set the dictionary elements.
    QHash<TYPE1, TYPE2*>::const_iterator i = sipCpp->constBegin();

    while (i != sipCpp->constEnd())
    {
        TYPE1 *t1 = new TYPE1(i.key());
        TYPE2 *t2 = i.value();

        PyObject *t1obj = sipConvertFromNewInstance(t1, sipClass_TYPE1, sipTransferObj);
        PyObject *t2obj = sipConvertFromNewInstance(t2, sipClass_TYPE2, sipTransferObj);

        if (t1obj == NULL || t2obj == NULL || PyDict_SetItem(d, t1obj, t2obj) < 0)
        {
            Py_DECREF(d);

            if (t1obj)
                Py_DECREF(t1obj);
            else
                delete t1;

            if (t2obj)
                Py_DECREF(t2obj);
            else
                delete t2;

            return NULL;
        }

        Py_DECREF(t1obj);
        Py_DECREF(t2obj);

        ++i;
    }

    return d;
%End

%ConvertToTypeCode
    PyObject *t1obj, *t2obj;
#if PY_VERSION_HEX >= 0x02050000
    Py_ssize_t i = 0;
#else
    int i = 0;
#endif

    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyDict_Check(sipPy))
            return 0;

        while (PyDict_Next(sipPy, &i, &t1obj, &t2obj))
        {
            if (!sipCanConvertToInstance(t1obj, sipClass_TYPE1, SIP_NOT_NONE))
                return 0;

            if (!sipCanConvertToInstance(t2obj, sipClass_TYPE2, SIP_NOT_NONE))
                return 0;
        } 

        return 1;
    }

    QHash<TYPE1, TYPE2*> *qm = new QHash<TYPE1, TYPE2*>;
 
    while (PyDict_Next(sipPy, &i, &t1obj, &t2obj))
    {
        int state1, state2;

        TYPE1 *t1 = reinterpret_cast<TYPE1 *>(sipConvertToInstance(t1obj, sipClass_TYPE1, sipTransferObj, SIP_NOT_NONE, &state1, sipIsErr));
        TYPE2 *t2 = reinterpret_cast<TYPE2 *>(sipConvertToInstance(t2obj, sipClass_TYPE2, sipTransferObj, SIP_NOT_NONE, &state2, sipIsErr));
 
        if (*sipIsErr)
        {
            sipReleaseInstance(t1, sipClass_TYPE1, state1);
            sipReleaseInstance(t2, sipClass_TYPE2, state2);

            delete qm;
            return 0;
        }

        qm->insert(*t1, t2);

        sipReleaseInstance(t1, sipClass_TYPE1, state1);
        sipReleaseInstance(t2, sipClass_TYPE2, state2);
    }
 
    *sipCppPtr = qm;
 
    return sipGetState(sipTransferObj);
%End
};


template<TYPE*>
%MappedType QSet<TYPE*>
//return a Python list of TYPE
{
%TypeHeaderCode
#include <qset.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l;

    if ((l = PyList_New(sipCpp->size())) == NULL)
        return NULL;

    // Set the list elements.
    QSet<TYPE*> set = *sipCpp;
    int i = 0;
    foreach (TYPE *value, set)
    {
        PyObject *obj = sipConvertFromNewInstance(value, sipClass_TYPE, sipTransferObj);
        if (obj == NULL || PyList_SET_ITEM (l, i, obj) < 0)
        {
            Py_DECREF(l);

            if (obj)
                Py_DECREF(obj);

            return NULL;
        }

        Py_DECREF(obj);
        i++;
    }
   
    return l;
%End

%ConvertToTypeCode
    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyList_Check(sipPy))
            return 0;
    }

    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyList_Check(sipPy))
            return 0;

        for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToInstance(PyList_GET_ITEM (sipPy, i), sipClass_TYPE, SIP_NOT_NONE))
                return 0;
    }

    QSet<TYPE*> *qs = new QSet<TYPE*>;
 
    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
    {
        int state;

        TYPE *t = reinterpret_cast<TYPE *>(sipConvertToInstance(PyList_GET_ITEM (sipPy, i), sipClass_TYPE, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));
 
        if (*sipIsErr)
        {
            sipReleaseInstance(t, sipClass_TYPE, state);

            delete qs;
            return 0;
        }

        *qs << t;

        sipReleaseInstance(t, sipClass_TYPE, state);
    }
 
    *sipCppPtr = qs;
 
    return sipGetState(sipTransferObj);
%End
};

template<TYPE>
%MappedType QSet<TYPE>
//return a Python list of TYPE
{
%TypeHeaderCode
#include <qset.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l;

    if ((l = PyList_New(sipCpp->size())) == NULL)
        return NULL;

    // Set the list elements.
    QSet<TYPE> set = *sipCpp;
    int i = 0;
    foreach (TYPE value, set)
    {
        PyObject *obj = sipConvertFromNewInstance(&value, sipClass_TYPE, sipTransferObj);
        if (obj == NULL || PyList_SET_ITEM (l, i, obj) < 0)
        {
            Py_DECREF(l);

            if (obj)
                Py_DECREF(obj);

            return NULL;
        }

        Py_DECREF(obj);
        i++;
    }
   
    return l;
%End

%ConvertToTypeCode
    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyList_Check(sipPy))
            return 0;
    }

    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyList_Check(sipPy))
            return 0;

        for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToInstance(PyList_GET_ITEM (sipPy, i), sipClass_TYPE, SIP_NOT_NONE))
                return 0;
    }

    QSet<TYPE> *qs = new QSet<TYPE>;
 
    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
    {
        int state;

        TYPE *t = reinterpret_cast<TYPE *>(sipConvertToInstance(PyList_GET_ITEM (sipPy, i), sipClass_TYPE, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));
 
        if (*sipIsErr)
        {
            sipReleaseInstance(t, sipClass_TYPE, state);

            delete qs;
            return 0;
        }

        *qs << *t;

        sipReleaseInstance(t, sipClass_TYPE, state);
    }
 
    *sipCppPtr = qs;
 
    return sipGetState(sipTransferObj);
%End
};

template<TYPE1,TYPE2>
%MappedType QPair<TYPE1,TYPE2>
//return a Python tuple of (TYPE1, TYPE2)
{
%TypeHeaderCode
#include <qpair.h>
%End

%ConvertFromTypeCode
    // Create the tuple.
    TYPE1 *t1 = new TYPE1(sipCpp->first);
    TYPE2 *t2 = new TYPE2(sipCpp->second);
    
    PyObject *t1obj = sipConvertFromNewInstance(t1, sipClass_TYPE1, sipTransferObj);
    PyObject *t2obj = sipConvertFromNewInstance(t2, sipClass_TYPE2, sipTransferObj);
    
    if (t1obj == NULL || t2obj == NULL)
    {   
        if (t1obj)
            Py_DECREF(t1obj);
        else
            delete t1;
    
        if (t2obj)
            Py_DECREF(t2obj);
        else
            delete t2;
    
        return NULL;
    }
       
    return Py_BuildValue((char *)"NN", t1obj, t2obj);
%End

%ConvertToTypeCode
    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
        return (PyTuple_Size(sipPy) == 2);


    int state1, state2;

    PyObject *t1obj = PyTuple_GET_ITEM(sipPy, 0);
    PyObject *t2obj = PyTuple_GET_ITEM(sipPy, 1);
    
    TYPE1 *t1 = reinterpret_cast<TYPE1 *>(sipConvertToInstance(t1obj, sipClass_TYPE1, sipTransferObj, SIP_NOT_NONE, &state1, sipIsErr));
    TYPE2 *t2 = reinterpret_cast<TYPE2 *>(sipConvertToInstance(t2obj, sipClass_TYPE2, sipTransferObj, SIP_NOT_NONE, &state2, sipIsErr));

    if (*sipIsErr)
    {
        sipReleaseInstance(t1, sipClass_TYPE1, state1);
        sipReleaseInstance(t2, sipClass_TYPE2, state2);

        return 0;
    }

    QPair<TYPE1, TYPE2> *qp = new QPair<TYPE1, TYPE2>;
 
    qp->first  = *t1;
    qp->second = *t2;

    *sipCppPtr = qp;
 
    return sipGetState(sipTransferObj);
%End
};

// QList<uint> is implemented as a Python list of integers.
%MappedType QList<uint>
//return a Python list of int

{
%TypeHeaderCode
#include <qlist.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l;

    if ((l = PyList_New(sipCpp->size())) == NULL)
        return NULL;

    // Set the list elements.
    for (int i = 0; i < sipCpp->size(); ++i)
    {
        PyObject *pobj;

        if ((pobj = PyInt_FromLong(sipCpp->value(i))) == NULL)
        {
            Py_DECREF(l);

            return NULL;
        }

        PyList_SET_ITEM(l, i, pobj);
    }

    return l;
%End

%ConvertToTypeCode
    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
        return PyList_Check(sipPy);

    QList<uint> *ql = new QList<uint>;
 
    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
        ql->append(PyInt_AsLong(PyList_GET_ITEM(sipPy, i)));
 
    *sipCppPtr = ql;
 
    return sipGetState(sipTransferObj);
%End
};

// QStack<TYPE*> is implemented as a Python list.
template<TYPE*>
%MappedType QStack<TYPE*>
{
%TypeHeaderCode
#include <qstack.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l;

    if ((l = PyList_New(sipCpp->size())) == NULL)
        return NULL;

    // Set the list elements.
    for (int i = 0; i < sipCpp->size(); ++i)
    {
        TYPE *t = (TYPE *)(sipCpp->at(i));
        PyObject *tobj;

        if ((tobj = sipConvertFromNewInstance(t, sipClass_TYPE, sipTransferObj)) == NULL)
        {
            Py_DECREF(l);
            delete t;

            return NULL;
        }

        PyList_SET_ITEM(l, i, tobj);
    }

    return l;
%End

%ConvertToTypeCode
    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyList_Check(sipPy))
            return 0;

        for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_TYPE, SIP_NOT_NONE))
                return 0;

        return 1;
    }

    QStack<TYPE*> *qv = new QStack<TYPE*>;
 
    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
    {
        int state;
        TYPE *t = reinterpret_cast<TYPE *>(sipConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_TYPE, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));
 
        if (*sipIsErr)
        {
            sipReleaseInstance(t, sipClass_TYPE, state);

            delete qv;
            return 0;
        }

        qv->append(t);

        sipReleaseInstance(t, sipClass_TYPE, state);
    }
 
    *sipCppPtr = qv;
 
    return sipGetState(sipTransferObj);
%End
};
