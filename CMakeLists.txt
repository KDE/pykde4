PROJECT(pykde4)

# This module can be built independant from the rest of kdebindings.

SET(CMAKE_MODULE_PATH ${pykde4_SOURCE_DIR}/cmake/modules )

FIND_PACKAGE(KDE4 REQUIRED)
FIND_PACKAGE(Qt4 REQUIRED)
INCLUDE(KDE4Defaults)
INCLUDE(MacroLibrary)
FIND_PACKAGE(PythonLibrary REQUIRED)
INCLUDE(PythonMacros)

FIND_PACKAGE(SIP REQUIRED)
IF(SIP_VERSION STRLESS "040701")    # These version numbers also appear in ../CMakeLists.txt
    MESSAGE(FATAL_ERROR "The version of SIP found is too old. 4.7.1 or later is needed.")
ENDIF(SIP_VERSION STRLESS "040701")
INCLUDE(SIPMacros)

FIND_PACKAGE(PyQt4 REQUIRED)
IF(PYQT4_VERSION STRLESS "040301")  # These version numbers also appear in ../CMakeLists.txt
    MESSAGE(FATAL_ERROR "The version of PyQt found is too old. 4.3.1 or later is required.")
ENDIF(PYQT4_VERSION STRLESS "040301")

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
    extra/kde3930
)

SET(SIP_INCLUDES ${PYQT4_SIP_DIR} sip)
SET(SIP_CONCAT_PARTS 8)
SET(SIP_TAGS ALL WS_X11 Qt_4_3_0 KDE_3_92_0)
SET(SIP_DISABLE_FEATURES VendorID PyQt_NoPrintRangeBug)
SET(SIP_EXTRA_OPTIONS -g)

ADD_DEFINITIONS(-D_REENTRANT -DQT_NO_DEBUG -DQT_CORE_LIB -DQT_GUI_LIB)

ADD_SIP_PYTHON_MODULE(PyKDE4.kdecore sip/kdecore/kdecoremod.sip ${KDE4_KDECORE_LIBS} ${KDE4_KPTY_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.solid sip/solid/solidmod.sip ${KDE4_SOLID_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.kdeui sip/kdeui/kdeuimod.sip ${KDE4_KDEUI_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.kio sip/kio/kiomod.sip ${KDE4_KIO_LIBS} ${KDE4_KFILE_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.kutils sip/kutils/kutilsmod.sip ${KDE4_KUTILS_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.kparts sip/kparts/kpartsmod.sip ${KDE4_KPARTS_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.ktexteditor sip/ktexteditor/ktexteditormod.sip ${KDE4_KTEXTEDITOR_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.khtml sip/khtml/khtmlmod.sip ${KDE4_KHTML_LIBS})

PYTHON_INSTALL(__init__.py ${PYTHON_SITE_PACKAGES_DIR}/PyKDE4)

# Install the .sip files for anyone that wants to build bindings on top of PyKDE4.
# (Don't forget the / at the end of sip/.)
INSTALL(DIRECTORY sip/ DESTINATION ${SIP_DEFAULT_SIP_DIR}/PyKDE4
    PATTERN "*~" EXCLUDE    # This sucks, why can't I just whitelist what I _do_ want?
    PATTERN ".svn" EXCLUDE
    PATTERN "*.in" EXCLUDE)

ADD_SUBDIRECTORY(tools)
ADD_SUBDIRECTORY(docs)
