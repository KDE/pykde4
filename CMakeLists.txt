project(pykde4)

# search packages used by KDE
find_package(KDE4 REQUIRED)
find_package(PythonLibrary)

include(KDE4Defaults)
include(MacroLibrary)
include(PythonMacros)

set(CMAKE_MODULE_PATH ${pykde4_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})

macro_log_feature(KDE4_FOUND "KDE libraries" "The KDE Development Platform" "kdelibs"
                  TRUE "" "Required to build PyKDE4")
macro_log_feature(PYTHONLIBRARY_FOUND "Python library" "The Python interpreter and libraries"
                  "http://python.org" TRUE "" "Required to build PyKDE4" )

include_directories(${KDE4_INCLUDES})

find_package(SIP)
macro_log_feature(SIP_FOUND "SIP" "The SIP binding generator" "http://riverbankcomputing.com" TRUE
                  "" "Required to build PyKDE4" )
include(SIPMacros)

if(SIP_VERSION STRLESS "040e00")    # These version numbers also appear in ../CMakeLists.txt
    message(FATAL_ERROR "The version of SIP found is too old. 4.14 or later is needed.")
endif(SIP_VERSION STRLESS "040e00")

find_package(PyQt4)
macro_log_feature(PYQT4_FOUND "PyQt4" "The PyQt bindings" "http://riverbankcomputing.com" TRUE
                  "" "Required to build PyKDE4")

if(PYQT4_VERSION STRLESS "040905")  # These version numbers also appear in ../CMakeLists.txt
    message(FATAL_ERROR "The version of PyQt found is too old. 4.9 or later is required.")
endif(PYQT4_VERSION STRLESS "040905")

set(SOPRANO_MIN_VERSION "2.0")
macro_optional_find_package(Soprano)
macro_log_feature(Soprano_FOUND "Soprano" "Soprano Libraries" "kdesupport" FALSE "" "Required for Soprano Python bindings.")

macro_optional_find_package(Nepomuk)
macro_log_feature(Nepomuk_FOUND "Nepomuk" "Nepomuk Libraries" "kdesupport" FALSE "" "Required for Nepomuk Python bindings.")

macro_optional_find_package(KdepimLibs)
macro_log_feature(KDEPIMLIBS_FOUND "Kdepimlibs" "KDE pim Libraries" "kdepimlibs" FALSE "" "Required for Akonadi Python bindings.")

macro_optional_find_package(PolkitQt)
macro_log_feature(POLKITQT_FOUND "Polkit-Qt" "Qt Wrapper around PolicyKit" "kdesupport" FALSE "" "Required to build PolicyKit-Qt support")

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

set(SIP_INCLUDES ${PYQT4_SIP_DIR} sip)
set(SIP_CONCAT_PARTS 8)
if (WIN32)
    set(SIP_TAGS ALL WS_WIN ${PYQT4_VERSION_TAG})
else (WIN32)
    set(SIP_TAGS ALL WS_X11 ${PYQT4_VERSION_TAG})
endif (WIN32)
set(SIP_DISABLE_FEATURES VendorID PyQt_NoPrintRangeBug)

# Use an extra option when compiling on Python 3.
if (PYTHON_VERSION_MAJOR GREATER 2)
    if(PYQT4_VERSION STRGREATER "040904")
	# Disable for newer PyQt
	set(SIP_EXTRA_OPTIONS -g -x PyKDE_QVector)
    else (PYQT4_VERSION STRGREATER "040904")
	set(SIP_EXTRA_OPTIONS -g)
    endif(PYQT4_VERSION STRGREATER "040904")
else (PYTHON_VERSION_MAJOR GREATER 2)
    if(PYQT4_VERSION STRGREATER "040904")
	# Disable for newer PyQt
	set(SIP_EXTRA_OPTIONS -g -x PyKDE_QVector -x Py_v3)
    else (PYQT4_VERSION STRGREATER "040904")
	set(SIP_EXTRA_OPTIONS -g -x Py_v3)
    endif(PYQT4_VERSION STRGREATER "040904")
endif (PYTHON_VERSION_MAJOR GREATER 2)

add_definitions(-D_REENTRANT -DQT_CORE_LIB -DQT_GUI_LIB -DUSING_SOPRANO_NRLMODEL_UNSTABLE_API)

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
endif(Soprano_FOUND)

if(Nepomuk_FOUND)
    include_directories(${NEPOMUK_INCLUDE_DIR})
    file(GLOB nepomuk_files_sip sip/nepomuk/*.sip)
    set(SIP_EXTRA_FILES_DEPEND ${nepomuk_files_sip})
    add_sip_python_module(PyKDE4.nepomuk sip/nepomuk/nepomukmod.sip ${NEPOMUK_LIBRARIES} ${NEPOMUK_QUERY_LIBRARIES} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${SOPRANO_LIBRARIES} ${KDE4_KIO_LIBS})
    set(PYKDE_MODULES "${PYKDE_MODULES} nepomuk")
endif(Nepomuk_FOUND)

if(KDEPIMLIBS_FOUND)
    include_directories(${KDEPIMLIBS_INCLUDE_DIR})
    file(GLOB akonadi_files_sip sip/akonadi/*.sip)
    set(SIP_EXTRA_FILES_DEPEND ${akonadi_files_sip})
    add_sip_python_module(PyKDE4.akonadi sip/akonadi/akonadimod.sip ${KDE4_AKONADI_LIBS} ${KDE4_AKONADI_KMIME_LIBS} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${KDE4_KDECORE_LIBS} ${KDE4_KDEUI_LIBS})
    set(PYKDE_MODULES "${PYKDE_MODULES} akonadi")
endif(KDEPIMLIBS_FOUND)

if(POLKITQT_FOUND)
    include_directories(${POLKITQT_INCLUDE_DIR})

    file(GLOB pollkitqt_files_sip sip/polkitqt/*.sip)

    # ${POLKITQT_INCLUDE_DIR} -- We don't use this directly, because we need the #includes
    # in the .sip file to be more specific otherwise they pick up the wrong action.h etc.

    set(SIP_EXTRA_FILES_DEPEND ${pollkitqt_files_sip})
    add_sip_python_module(PyKDE4.polkitqt sip/polkitqt/polkitqtmod.sip ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${POLKITQT_LIBRARIES})
    set(PYKDE_MODULES "${PYKDE_MODULES} polkitqt")
endif(POLKITQT_FOUND)

python_install(__init__.py ${PYTHON_SITE_PACKAGES_INSTALL_DIR}/PyKDE4)

# Setup and install pykdeconfig.py

# Turn these into formatted strings.
set(_SIP_TAGS)
foreach (_TAG ${SIP_TAGS})
    set(_SIP_TAGS "${_SIP_TAGS} -t ${_TAG}")
endforeach (_TAG)

set(_SIP_X)
foreach (_X ${SIP_DISABLE_FEATURES})
    set(_SIP_X "${_SIP_X} -X ${_X}")
endforeach (_X ${SIP_DISABLE_FEATURES})

get_filename_component(LIB_DIR ${KDE4_LIB_DIR} NAME)

set(SIP_CONFIGURATION "
kde_version_parts = '${KDE_VERSION}'.split('.')
kde_version_hex = int(kde_version_parts[0])*65536 + int(kde_version_parts[1])*256 + int(kde_version_parts[2])
_pkg_config = {
    'dist_name':            '',
    'kde_version':          kde_version_hex,
    'kde_version_extra':    '',
    'kde_version_sfx':      '',
    'kde_version_str':      '${KDE_VERSION}',
    'kdebasedir':           '${CMAKE_INSTALL_PREFIX}',
    'kdeincdir':            '${KDE4_INCLUDE_DIR}',
    'kdelibdir':            '${KDE4_LIB_DIR}',
    'konsolepart':          'False',
    'libdir':               '${LIB_DIR}',
    'pykde_kde_sip_flags':  '${_SIP_TAGS} ${_SIP_X} ${SIP_EXTRA_OPTIONS}',
    'pykde_mod_dir':        '${PYTHON_SITE_PACKAGES_INSTALL_DIR}/PyKDE4',
    'pykde_modules':        '${PYKDE_MODULES}',
    'pykde_sip_dir':        '${SIP_DEFAULT_SIP_DIR}/PyKDE4',
    'pykde_version':        kde_version_hex,
    'pykde_version_str':    '${KDE_VERSION}'
}

_default_macros = None")

configure_file(pykdeconfig.py.in ${CMAKE_CURRENT_BINARY_DIR}/pykdeconfig.py)
python_install(${CMAKE_CURRENT_BINARY_DIR}/pykdeconfig.py ${PYTHON_SITE_PACKAGES_INSTALL_DIR}/PyKDE4)

# Install the .sip files for anyone that wants to build bindings on top of PyKDE4.
# (Don't forget the / at the end of sip/.)
install(DIRECTORY sip/ DESTINATION ${SIP_DEFAULT_SIP_DIR}/PyKDE4
    PATTERN "*~" EXCLUDE    # This sucks, why can't I just whitelist what I _do_ want?
    PATTERN ".svn" EXCLUDE
    PATTERN "*.in" EXCLUDE)

add_subdirectory(tools)
#add_subdirectory(docs)
add_subdirectory(examples)
if (PYTHON_VERSION_MAJOR LESS 3)
    add_subdirectory(kpythonpluginfactory)
endif (PYTHON_VERSION_MAJOR LESS 3)

macro_display_feature_log()
