project(pykde4)

cmake_minimum_required(VERSION 2.8.6 FATAL_ERROR)

# search packages used by KDE
find_package(KDE4 4.9.4 REQUIRED)

# Match what's used in the main macros
cmake_policy(SET CMP0002 OLD)
find_package(PythonLibrary)

include(KDE4Defaults)
include(MacroLibrary)
include(PythonMacros)
include(FeatureSummary)

option(PYKDEUIC4_ALTINSTALL "Enable parallel-installation of the PyKDE4 tools" FALSE)

set(CMAKE_MODULE_PATH ${pykde4_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})

find_package(PythonLibrary)

set_package_properties(KDE4 PROPERTIES DESCRIPTION "The KDE libraries"
                       URL "http://www.kde.org" TYPE REQUIRED
                       PURPOSE "Required to build PyKDE4")
set_package_properties(PythonLibrary PROPERTIES DESCRIPTION
                       "The Python Library" URL "http://www.python.org"
                       TYPE REQUIRED PURPOSE "Required to build PyKDE4")
set_package_properties(PythonInterp PROPERTIES
                       DESCRIPTION "The Python interpreter"
                       URL "http://www.python.org" TYPE REQUIRED
                       PURPOSE "Required to build PyKDE4")

include_directories(${KDE4_INCLUDES})

find_package(SIP)
set_package_properties(SIP PROPERTIES DESCRIPTION "The SIP binding generator"
                       URL "http://riverbankcomputing.com" TYPE REQUIRED
                       PURPOSE "Required to build PyKDE4")

include(SIPMacros)

if(SIP_VERSION STRLESS "040e00")    # These version numbers also appear in ../CMakeLists.txt
    message(FATAL_ERROR "The version of SIP found is too old. 4.14 or later is needed.")
endif()

find_package(PyQt4)
set_package_properties(PyQt4 PROPERTIES DESCRIPTION "The PyQt bindings"
                       URL "http://riverbankcomputing.com" TYPE REQUIRED
                       PURPOSE "Required to build PyKDE4")

if(PYQT4_VERSION STRLESS "040905")  # These version numbers also appear in ../CMakeLists.txt
    message(FATAL_ERROR "The version of PyQt found is too old. 4.9 or later is required.")
endif()

macro_optional_find_package(Soprano)
set_package_properties(Soprano PROPERTIES DESCRIPTION "The Soprano libraries"
                       URL "http://projects.kde.org/kdesupport/soprano"
                       TYPE OPTIONAL PURPOSE
                       "Required for Soprano Python bindings")

macro_optional_find_package(Nepomuk)
set_package_properties(Nepomuk PROPERTIES DESCRIPTION "The Nepomuk libraries"
                       URL "http://projects.kde.org/kde/kdelibs/" TYPE OPTIONAL
                       PURPOSE "Required for Nepomuk Python bindings")

macro_optional_find_package(KdepimLibs)
set_package_properties(KdepimLibs PROPERTIES DESCRIPTION "The KDE PIM libraries"
                       URL "http://projects.kde.org/kde/kdepimlibs" TYPE OPTIONAL
                       PURPOSE "Required for the Akonadi Python bindings")

macro_optional_find_package(PolkitQt)
set_package_properties(PolkitQt PROPERTIES DESCRIPTION "Qt wrapper around Polkit"
                       TYPE OPTIONAL PURPOSE
                       "Required to build Python Polkit bindings")

include_directories(
    ${PYTHON_INCLUDE_PATH}
    ${SIP_INCLUDE_DIR}
    ${QT_INCLUDE_DIR}
    ${QT_QT_INCLUDE_DIR}
    ${QT_QTCORE_INCLUDE_DIR}
    ${QT_QTDESIGNER_INCLUDE_DIR}
    ${QT_QTGUI_INCLUDE_DIR}
    ${QT_QTNETWORK_INCLUDE_DIR}
    ${QT_QTOPENGL_INCLUDE_DIR}
    ${QT_QTSQL_INCLUDE_DIR}
    ${QT_QTXML_INCLUDE_DIR}
    ${QT_QTSVG_INCLUDE_DIR}
    ${QT_QTWEBKIT_INCLUDE_DIR}
    ${KDE4_INCLUDE_DIR}
    ${KDE4_INCLUDE_DIR}/solid
    ${KDE4_INCLUDE_DIR}/kio
    ${KDE4_INCLUDE_DIR}/dom
    ${KDE4_INCLUDE_DIR}/ksettings
    ${KDE4_INCLUDE_DIR}/knewstuff2
    ${KDE4_INCLUDE_DIR}/dnssd
    ${KDE4_PHONON_INCLUDES}
    ${KDEPIMLIBS_INCLUDE_DIRS}
)

set(SIP_INCLUDES ${CMAKE_BINARY_DIR} ${PYQT4_SIP_DIR} sip)
set(SIP_CONCAT_PARTS 8)
if (WIN32)
    set(SIP_TAGS ALL WS_WIN ${PYQT4_VERSION_TAG})
else ()
    set(SIP_TAGS ALL WS_X11 ${PYQT4_VERSION_TAG})
endif ()
set(SIP_DISABLE_FEATURES VendorID PyQt_NoPrintRangeBug)

set(SIP_FILES_INSTALL_DIR ${SHARE_INSTALL_PREFIX}/sip)

# Use an extra option when compiling on Python 3.
if (PYTHON_VERSION_MAJOR GREATER 2)
    if(PYQT4_VERSION STRGREATER "040904")
	    # Disable for features in newer Qt
        if (PYQT4_VERSION STRGREATER "040a04")
            # GLuint + QVector (PyQt > 4.11)
            set(SIP_EXTRA_OPTIONS -P -g -x PyKDE_QVector -x PyKDE_GLuint)
        else ()
            # QVector (PyQt < 4.11)
            set(SIP_EXTRA_OPTIONS -P -g -x PyKDE_QVector)
        endif ()
    else ()
	    set(SIP_EXTRA_OPTIONS -g)
    endif()
else (PYTHON_VERSION_MAJOR GREATER 2)
    if(PYQT4_VERSION STRGREATER "040904")
	# Disable for newer PyQt
        if (PYQT4_VERSION STRGREATER "040a04")
            # GLuint + QVector (PyQt > 4.11)
            set(SIP_EXTRA_OPTIONS -P -g -x PyKDE_QVector -x Py_v3 -x PyKDE_GLuint)
        else ()
            # QVector (PyQt < 4.11)
            set(SIP_EXTRA_OPTIONS -P -g -x PyKDE_QVector -x Py_v3)
        endif ()
    else ()
	    set(SIP_EXTRA_OPTIONS -g -x Py_v3)
    endif()
endif ()

add_definitions(-D_REENTRANT -DQT_CORE_LIB -DQT_GUI_LIB -DUSING_SOPRANO_NRLMODEL_UNSTABLE_API -DSIP_PROTECTED_IS_PUBLIC -Dprotected=public)

include(PyKDEConfigurationInformation.cmake)

# Only install pykdeconfig.py if PyQt itself has installed pyqtconfig.py, since
# its absence indicates PyQt was built with the new build system and
# pykdeconfig will not work.
execute_process(COMMAND "${PYTHON_EXECUTABLE}" -c "import PyQt4.pyqtconfig"
                RESULT_VARIABLE _exit_code OUTPUT_QUIET ERROR_QUIET)
if (NOT _exit_code)
    python_install(${CMAKE_CURRENT_BINARY_DIR}/pykdeconfig.py ${PYTHON_SITE_PACKAGES_INSTALL_DIR}/PyKDE4)
endif ()

file(GLOB kdecore_files_sip sip/kdecore/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kdecore_files_sip})
add_sip_python_module(PyKDE4.kdecore sip/kdecore/kdecoremod.sip ${KDE4_KDECORE_LIBS} ${KDE4_KPTY_LIBS} ${QT_QTNETWORK_LIBRARY})

file(GLOB solid_files_sip sip/solid/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${solid_files_sip})
add_sip_python_module(PyKDE4.solid sip/solid/solidmod.sip ${KDE4_SOLID_LIBS} ${QT_QTCORE_LIBRARY})

file(GLOB kdeui_files_sip sip/kdeui/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kdeui_files_sip})
add_sip_python_module(PyKDE4.kdeui sip/kdeui/kdeuimod.sip ${KDE4_KDEUI_LIBS} ${QT_QTXML_LIBRARY})

file(GLOB kio_files_sip sip/kio/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kio_files_sip})
add_sip_python_module(PyKDE4.kio sip/kio/kiomod.sip ${KDE4_KIO_LIBS} ${KDE4_KFILE_LIBS})

file(GLOB kutils_files_sip sip/kutils/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kutils_files_sip})
add_sip_python_module(PyKDE4.kutils sip/kutils/kutilsmod.sip ${KDE4_KUTILS_LIBS} ${QT_QTGUI_LIBRARY} ${QT_QTCORE_LIBRARY} ${KDE4_KDEUI_LIBS})

file(GLOB kparts_files_sip sip/kparts/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kparts_files_sip})
add_sip_python_module(PyKDE4.kparts sip/kparts/kpartsmod.sip ${KDE4_KPARTS_LIBS})

file(GLOB ktexteditor_files_sip sip/ktexteditor/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${ktexteditor_files_sip})
add_sip_python_module(PyKDE4.ktexteditor sip/ktexteditor/ktexteditormod.sip ${KDE4_KTEXTEDITOR_LIBS} ${KDE4_KPARTS_LIBS} ${KDE4_KDEUI_LIBS} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY})

file(GLOB khtml_files_sip sip/khtml/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${khtml_files_sip})
add_sip_python_module(PyKDE4.khtml sip/khtml/khtmlmod.sip ${KDE4_KHTML_LIBS})

file(GLOB knewstuff_files_sip sip/knewstuff/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${knewstuff_files_sip})
add_sip_python_module(PyKDE4.knewstuff sip/knewstuff/knewstuffmod.sip ${KDE4_KNEWSTUFF2_LIBS} ${KDE4_KNEWSTUFF3_LIBS} ${QT_QTCORE_LIBRARY})

file(GLOB dnssd_files_sip sip/dnssd/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${dnssd_files_sip})
add_sip_python_module(PyKDE4.dnssd sip/dnssd/dnssdmod.sip ${KDE4_KDNSSD_LIBS} ${QT_QTCORE_LIBRARY})

file(GLOB phonon_files_sip sip/phonon/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${phonon_files_sip})
add_sip_python_module(PyKDE4.phonon sip/phonon/phononmod.sip ${PHONON_LIBS} ${QT_QTDBUS_LIBRARY} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY})

file(GLOB plasma_files_sip sip/plasma/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${plasma_files_sip})
add_sip_python_module(PyKDE4.plasma sip/plasma/plasmamod.sip ${KDE4_PLASMA_LIBS} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${QT_QTUITOOLS_LIBRARY} ${KDE4_KIO_LIBRARY} ${KDE4_KDECORE_LIBRARY} ${KDE4_KDEUI_LIBRARY})

file(GLOB kterminal_files_sip sip/kterminal/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kterminal_files_sip})
add_sip_python_module(PyKDE4.kterminal sip/kterminal/kterminalmod.sip ${KDE4_TERMINAL_LIBS} ${KDE4_KPARTS_LIBS} ${KDE4_KDEUI_LIBS} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY})

set(PYKDE_MODULES "kdecore solid kdeui kio kutils kparts ktexteditor dnssd phonon plasma kterminal")

if(Soprano_FOUND)
    include_directories(${SOPRANO_INCLUDE_DIR})
    file(GLOB soprano_files_sip sip/soprano/*.sip)
    set(SIP_EXTRA_FILES_DEPEND ${soprano_files_sip})
    add_sip_python_module(PyKDE4.soprano sip/soprano/sopranomod.sip ${SOPRANO_LIBRARIES} ${SOPRANO_CLIENT_LIBRARIES} ${SOPRANO_SERVER_LIBRARIES} ${QT_QTCORE_LIBRARY} ${QT_QTNETWORK_LIBRARY})
    set(PYKDE_MODULES "${PYKDE_MODULES} soprano")
endif()

if(Nepomuk_FOUND)
    include_directories(${NEPOMUK_INCLUDE_DIR})
    file(GLOB nepomuk_files_sip sip/nepomuk/*.sip)
    set(SIP_EXTRA_FILES_DEPEND ${nepomuk_files_sip})
    add_sip_python_module(PyKDE4.nepomuk sip/nepomuk/nepomukmod.sip ${NEPOMUK_LIBRARIES} ${NEPOMUK_QUERY_LIBRARIES} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${SOPRANO_LIBRARIES} ${KDE4_KIO_LIBS})
    set(PYKDE_MODULES "${PYKDE_MODULES} nepomuk")
endif()

if(KdepimLibs_FOUND)
    find_package(Boost 1.34.0)
    set_package_properties(Boost PROPERTIES DESCRIPTION "Boost C++ Libraries"
                           URL "http://www.boost.org" TYPE REQUIRED
                           PURPOSE "Boost is required by Akonadi")
    include_directories(${KDEPIMLIBS_INCLUDE_DIRS})
    file(GLOB akonadi_files_sip sip/akonadi/*.sip)
    set(SIP_EXTRA_FILES_DEPEND ${akonadi_files_sip})
    add_sip_python_module(PyKDE4.akonadi sip/akonadi/akonadimod.sip ${KDE4_AKONADI_LIBS} ${KDE4_AKONADI_KMIME_LIBS} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${KDE4_KDECORE_LIBS} ${KDE4_KDEUI_LIBS})
    set(PYKDE_MODULES "${PYKDE_MODULES} akonadi")
endif()

if(POLKITQT_FOUND)
    include_directories(${POLKITQT_INCLUDE_DIR})

    file(GLOB pollkitqt_files_sip sip/polkitqt/*.sip)

    # ${POLKITQT_INCLUDE_DIR} -- We don't use this directly, because we need the #includes
    # in the .sip file to be more specific otherwise they pick up the wrong action.h etc.

    set(SIP_EXTRA_FILES_DEPEND ${pollkitqt_files_sip})
    add_sip_python_module(PyKDE4.polkitqt sip/polkitqt/polkitqtmod.sip ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${POLKITQT_LIBRARIES})
    set(PYKDE_MODULES "${PYKDE_MODULES} polkitqt")
endif()

python_install(__init__.py ${PYTHON_SITE_PACKAGES_INSTALL_DIR}/PyKDE4)

# Install the .sip files for anyone that wants to build bindings on top of PyKDE4.
# (Don't forget the / at the end of sip/.)
install(DIRECTORY sip/ DESTINATION ${SIP_FILES_INSTALL_DIR}/PyKDE4
    PATTERN "*~" EXCLUDE    # This sucks, why can't I just whitelist what I _do_ want?
    PATTERN ".svn" EXCLUDE
    PATTERN "*.in" EXCLUDE)

add_subdirectory(tools)
#add_subdirectory(docs)
add_subdirectory(examples)
if (PYTHON_VERSION_MAJOR LESS 3)
    add_subdirectory(kpythonpluginfactory)
endif ()

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
