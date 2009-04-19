PROJECT(pykde4)

# This module can be built independant from the rest of kdebindings.
SET(CMAKE_MODULE_PATH ${pykde4_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})

# Fix output file conflict with the Ruby bindings
IF(CMAKE_MAJOR_VERSION EQUAL 2 AND CMAKE_MINOR_VERSION LESS 6)
    SET(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib/pykde)
ELSE(CMAKE_MAJOR_VERSION EQUAL 2 AND CMAKE_MINOR_VERSION LESS 6)
    SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib/pykde)
ENDIF(CMAKE_MAJOR_VERSION EQUAL 2 AND CMAKE_MINOR_VERSION LESS 6)

FIND_PACKAGE(PythonLibrary REQUIRED)
INCLUDE(PythonMacros)

FIND_PACKAGE(SIP REQUIRED)
IF(SIP_VERSION STRLESS "040708")    # These version numbers also appear in ../CMakeLists.txt
    MESSAGE(FATAL_ERROR "The version of SIP found is too old. 4.7.8 or later is needed.")
ENDIF(SIP_VERSION STRLESS "040708")
INCLUDE(SIPMacros)

FIND_PACKAGE(PyQt4 REQUIRED)
IF(PYQT4_VERSION STRLESS "040404")  # These version numbers also appear in ../CMakeLists.txt
    MESSAGE(FATAL_ERROR "The version of PyQt found is too old. 4.4.4 or later is required.")
ENDIF(PYQT4_VERSION STRLESS "040404")

SET(SOPRANO_MIN_VERSION "2.0")
MACRO_OPTIONAL_FIND_PACKAGE(Soprano)
MACRO_LOG_FEATURE(Soprano_FOUND "Soprano" "Soprano Libraries" "kdesupport" FALSE "" "Required for Soprano Python bindings.")

MACRO_OPTIONAL_FIND_PACKAGE(Nepomuk)
MACRO_LOG_FEATURE(Nepomuk_FOUND "Nepomuk" "Nepomuk Libraries" "kdesupport" FALSE "" "Required for Nepomuk Python bindings.")

MACRO_OPTIONAL_FIND_PACKAGE(KdepimLibs)
MACRO_LOG_FEATURE(KDEPIMLIBS_FOUND "Kdepimlibs" "KDE pim Libraries" "kdepimlibs" FALSE "" "Required for Akonadi Python bindings.")

INCLUDE_DIRECTORIES(
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
    ${KDE4_INCLUDE_DIR}
    ${KDE4_INCLUDE_DIR}/solid
    ${KDE4_INCLUDE_DIR}/kio
    ${KDE4_INCLUDE_DIR}/kdeprint
    ${KDE4_INCLUDE_DIR}/kdeprint/lpr
    ${KDE4_INCLUDE_DIR}/dom
    ${KDE4_INCLUDE_DIR}/ksettings
    ${KDE4_INCLUDE_DIR}/knewstuff2
    ${KDE4_INCLUDE_DIR}/dnssd
    ${KDEPIMLIBS_INCLUDE_DIRS}
)

SET(SIP_INCLUDES ${PYQT4_SIP_DIR} sip)
SET(SIP_CONCAT_PARTS 8)
SET(SIP_TAGS ALL WS_X11 ${PYQT4_VERSION_TAG})
SET(SIP_DISABLE_FEATURES VendorID PyQt_NoPrintRangeBug)
SET(SIP_EXTRA_OPTIONS -g)

ADD_DEFINITIONS(-D_REENTRANT -DQT_NO_DEBUG -DQT_CORE_LIB -DQT_GUI_LIB)

FILE(GLOB kdecore_files_sip sip/kdecore/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kdecore_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.kdecore sip/kdecore/kdecoremod.sip ${KDE4_KDECORE_LIBS} ${KDE4_KPTY_LIBS} ${QT_QTNETWORK_LIBRARY})

FILE(GLOB solid_files_sip sip/solid/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${solid_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.solid sip/solid/solidmod.sip ${KDE4_SOLID_LIBS} ${QT_QTCORE_LIBRARY})

FILE(GLOB kdeui_files_sip sip/kdeui/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kdeui_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.kdeui sip/kdeui/kdeuimod.sip ${KDE4_KDEUI_LIBS} ${QT_QTXML_LIBRARY})

FILE(GLOB kio_files_sip sip/kio/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kio_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.kio sip/kio/kiomod.sip ${KDE4_KIO_LIBS} ${KDE4_KFILE_LIBS})

FILE(GLOB kutils_files_sip sip/kutils/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kutils_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.kutils sip/kutils/kutilsmod.sip ${KDE4_KUTILS_LIBS} ${QT_QTGUI_LIBRARY} ${QT_QTCORE_LIBRARY} ${KDE4_KDEUI_LIBS})

FILE(GLOB kparts_files_sip sip/kparts/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${kparts_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.kparts sip/kparts/kpartsmod.sip ${KDE4_KPARTS_LIBS})

FILE(GLOB ktexteditor_files_sip sip/ktexteditor/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${ktexteditor_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.ktexteditor sip/ktexteditor/ktexteditormod.sip ${KDE4_KTEXTEDITOR_LIBS} ${KDE4_KPARTS_LIBS} ${KDE4_KDEUI_LIBS} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY})

FILE(GLOB khtml_files_sip sip/khtml/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${khtml_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.khtml sip/khtml/khtmlmod.sip ${KDE4_KHTML_LIBS})

FILE(GLOB knewstuff_files_sip sip/knewstuff/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${knewstuff_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.knewstuff sip/knewstuff/knewstuffmod.sip ${KDE4_KNEWSTUFF2_LIBS} ${QT_QTCORE_LIBRARY})

FILE(GLOB dnssd_files_sip sip/dnssd/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${dnssd_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.dnssd sip/dnssd/dnssdmod.sip ${KDE4_KDNSSD_LIBS} ${QT_QTCORE_LIBRARY})

FILE(GLOB phonon_files_sip sip/phonon/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${phonon_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.phonon sip/phonon/phononmod.sip ${PHONON_LIBS} ${QT_QTDBUS_LIBRARY} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY})

FILE(GLOB plasma_files_sip sip/plasma/*.sip)
set(SIP_EXTRA_FILES_DEPEND ${plasma_files_sip})
ADD_SIP_PYTHON_MODULE(PyKDE4.plasma sip/plasma/plasmamod.sip ${KDE4_PLASMA_LIBS} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${QT_QTUITOOLS_LIBRARY} ${KDE4_KIO_LIBRARY} ${KDE4_KDECORE_LIBRARY} ${KDE4_KDEUI_LIBRARY})

SET(PYKDE_MODULES "kdecore solid kdeui kio kutils kparts ktexteditor dnssd phonon plasma")

IF(Soprano_FOUND)
    FILE(GLOB soprano_files_sip sip/soprano/*.sip)
    set(SIP_EXTRA_FILES_DEPEND ${soprano_files_sip})
    ADD_SIP_PYTHON_MODULE(PyKDE4.soprano sip/soprano/sopranomod.sip ${SOPRANO_LIBRARIES} ${SOPRANO_CLIENT_LIBRARIES} ${SOPRANO_SERVER_LIBRARIES} ${QT_QTCORE_LIBRARY} ${QT_QTNETWORK_LIBRARY})
    SET(PYKDE_MODULES "${PYKDE_MODULES} soprano")
ENDIF(Soprano_FOUND)

IF(Nepomuk_FOUND)
    FILE(GLOB nepomuk_files_sip sip/nepomuk/*.sip)
    set(SIP_EXTRA_FILES_DEPEND ${nepomuk_files_sip})
    ADD_SIP_PYTHON_MODULE(PyKDE4.nepomuk sip/nepomuk/nepomukmod.sip ${NEPOMUK_LIBRARIES} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${SOPRANO_LIBRARIES})
    SET(PYKDE_MODULES "${PYKDE_MODULES} nepomuk")
ENDIF(Nepomuk_FOUND)

IF(KDEPIMLIBS_FOUND)
    FILE(GLOB akonadi_files_sip sip/akonadi/*.sip)
    set(SIP_EXTRA_FILES_DEPEND ${akonadi_files_sip})
    ADD_SIP_PYTHON_MODULE(PyKDE4.akonadi sip/akonadi/akonadimod.sip ${KDE4_AKONADI_LIBS} ${KDE4_AKONADI_KMIME_LIBS} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${KDE4_KDECORE_LIBS} ${KDE4_KDEUI_LIBS})
    SET(PYKDE_MODULES "${PYKDE_MODULES} akonadi")
ENDIF(KDEPIMLIBS_FOUND)

PYTHON_INSTALL(__init__.py ${PYTHON_SITE_PACKAGES_DIR}/PyKDE4)

MESSAGE(STATUS "KDE_VERSION: ${KDE_VERSION}")
MESSAGE(STATUS "KDE4_INCLUDE_DIR: ${KDE4_INCLUDE_DIR}")
MESSAGE(STATUS "KDE4_LIB_DIR: ${KDE4_LIB_DIR}")
MESSAGE(STATUS "PYTHON_SITE_PACKAGES_DIR: ${PYTHON_SITE_PACKAGES_DIR}")

# Setup and install pykdeconfig.py

# Turn these into formatted strings.
SET(_SIP_TAGS)
FOREACH (_TAG ${SIP_TAGS})
    SET(_SIP_TAGS "${_SIP_TAGS} -t ${_TAG}")
ENDFOREACH (_TAG)

SET(_SIP_X)
FOREACH (_X ${SIP_DISABLE_FEATURES})
    SET(_SIP_X "${_SIP_X} -X ${_X}")
ENDFOREACH (_X ${SIP_DISABLE_FEATURES})

GET_FILENAME_COMPONENT(LIB_DIR ${KDE4_LIB_DIR} NAME)

SET(SIP_CONFIGURATION "
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
    'pykde_mod_dir':        '${PYTHON_SITE_PACKAGES_DIR}/PyKDE4',
    'pykde_modules':        '${PYKDE_MODULES}',
    'pykde_sip_dir':        '${SIP_DEFAULT_SIP_DIR}/PyKDE4',
    'pykde_version':        kde_version_hex,
    'pykde_version_str':    '${KDE_VERSION}'
}

_default_macros = None")

CONFIGURE_FILE(pykdeconfig.py.in ${CMAKE_CURRENT_BINARY_DIR}/pykdeconfig.py)
PYTHON_INSTALL(${CMAKE_CURRENT_BINARY_DIR}/pykdeconfig.py ${PYTHON_SITE_PACKAGES_DIR}/PyKDE4)

# Install the .sip files for anyone that wants to build bindings on top of PyKDE4.
# (Don't forget the / at the end of sip/.)
INSTALL(DIRECTORY sip/ DESTINATION ${SIP_DEFAULT_SIP_DIR}/PyKDE4
    PATTERN "*~" EXCLUDE    # This sucks, why can't I just whitelist what I _do_ want?
    PATTERN ".svn" EXCLUDE
    PATTERN "*.in" EXCLUDE)

ADD_SUBDIRECTORY(tools)
#ADD_SUBDIRECTORY(docs)
ADD_SUBDIRECTORY(examples)
ADD_SUBDIRECTORY(kpythonpluginfactory)
#ADD_SUBDIRECTORY(pykdedocs)
