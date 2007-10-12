#
PROJECT(pykde4)

SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules )

FIND_PACKAGE(KDE4 REQUIRED)

FIND_PACKAGE(Qt4 REQUIRED)
MESSAGE(STATUS "Found Qt4 library in ${QT_LIBRARY_DIR}")

INCLUDE(KDE4Defaults)
INCLUDE(MacroLibrary)

###########################################################################
# Find Python
INCLUDE(FindPythonInterp)
MESSAGE(STATUS "Found Python executable: ${PYTHON_EXECUTABLE}")

EXECUTE_PROCESS(COMMAND ${PYTHON_EXECUTABLE}  ${CMAKE_SOURCE_DIR}/cmake/modules/FindLibPython.py OUTPUT_VARIABLE python_config)
STRING(REGEX REPLACE ".*exec_prefix:([^\n]+).*$" "\\1" PYTHON_PREFIX ${python_config})
STRING(REGEX REPLACE ".*\nshort_version:([^\n]+).*$" "\\1" PYTHON_SHORT_VERSION ${python_config})
STRING(REGEX REPLACE ".*\nsite_packages_dir:([^\n]+).*$" "\\1" PYTHON_SITE_PACKAGES_DIR ${python_config})
FIND_LIBRARY(PYTHON_LIBRARY NAMES python${PYTHON_SHORT_VERSION} PATHS ${PYTHON_PREFIX}/lib NO_DEFAULT_PATH)
MESSAGE(STATUS "Found Python library: ${PYTHON_LIBRARY}")

MESSAGE(STATUS "KDE4_KDECORE_LIBS: ${KDE4_KDECORE_LIBS}")

###########################################################################
# Find SIP
EXECUTE_PROCESS(COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_SOURCE_DIR}/cmake/modules/FindSIP.py OUTPUT_VARIABLE sip_config)
IF(NOT sip_config)
  # Failure to run
  MESSAGE(FATAL_ERROR "SIP not found")
ENDIF(NOT sip_config)

STRING(REGEX REPLACE ".*\nsip_version:([^\n]+).*$" "\\1" SIP_VERSION ${sip_config})
STRING(REGEX REPLACE ".*\nsip_version_str:([^\n]+).*$" "\\1" SIP_VERSION_STR ${sip_config})
STRING(REGEX REPLACE ".*\nsip_bin:([^\n]+).*$" "\\1" SIP_EXECUTABLE ${sip_config})
STRING(REGEX REPLACE ".*\npy_inc_dir:([^\n]+).*$" "\\1" PYTHON_INCLUDE_DIR ${sip_config})
STRING(REGEX REPLACE ".*\nsip_inc_dir:([^\n]+).*$" "\\1" SIP_INCLUDE_DIR ${sip_config})
STRING(REGEX REPLACE ".*\npy_lib_dir:([^\n]+).*$" "\\1" PYTHON_LIB_DIR ${sip_config})

MESSAGE(STATUS "Found SIP version: ${SIP_VERSION_STR}")

# Check SIP version.
#    if sipcfg.sip_version < sip_min_v4_version:
#        sipcfg.error("This version of PyKDE requires SIP v%s or later" % sipcfg.version_to_string(minv))

###########################################################################
# Find PyQt
EXECUTE_PROCESS(COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_SOURCE_DIR}/cmake/modules/FindPyQt.py OUTPUT_VARIABLE pyqt_config)
IF(NOT pyqt_config)
  # Failure to run
  MESSAGE(FATAL_ERROR "PyQt not found")
ENDIF(NOT pyqt_config)

STRING(REGEX REPLACE ".*\npyqt_version:([^\n]+).*$" "\\1" PYQT_VERSION ${pyqt_config})
STRING(REGEX REPLACE ".*\npyqt_version_str:([^\n]+).*$" "\\1" PYQT_VERSION_STR ${pyqt_config})
STRING(REGEX REPLACE ".*\npyqt_sip_dir:([^\n]+).*$" "\\1" PYQT_SIP_DIR ${pyqt_config})
MESSAGE(STATUS "Found PyQt version: ${PYQT_VERSION_STR}")

###########################################################################
# Run SIP.
SET(SIP_INCLUDES)


MACRO(ADD_SIP_PYTHON_MODULE MODULE_NAME MODULE_SIP)

    SET(EXTRA_LINK_LIBRARIES ${ARGN})

    STRING(REPLACE "." "/" _x ${MODULE_NAME})
    GET_FILENAME_COMPONENT(_parent_module_path ${_x}  PATH)
    GET_FILENAME_COMPONENT(_child_module_name ${_x} NAME)

    GET_FILENAME_COMPONENT(_module_path ${MODULE_SIP} PATH)
    GET_FILENAME_COMPONENT(_abs_module_sip ${MODULE_SIP} ABSOLUTE)

    # We give this target a long logical target name.
    # (This is to avoid having the library name clash with any already
    # install library names. If that happens then cmake dependancy
    # tracking get confused.)
    STRING(REPLACE "." "_" _logical_name ${MODULE_NAME})
    SET(_logical_name "python_module_${_logical_name}")

    FILE(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${_module_path})    # Output goes in this dir.

    SET(_sip_includes)
    FOREACH (_inc ${SIP_INCLUDES})
        GET_FILENAME_COMPONENT(_abs_inc ${_inc} ABSOLUTE)
        LIST(APPEND _sip_includes -I ${_abs_inc})
    ENDFOREACH (_inc )
    
    SET(_message "-DMESSAGE=Generating CPP code for module ${MODULE_NAME}")
    ADD_CUSTOM_COMMAND(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${_module_path}/sip${_child_module_name}part0.cpp
        COMMAND ${CMAKE_COMMAND} ${_message} -P ${CMAKE_SOURCE_DIR}/cmake/modules/print_status.cmake
        COMMAND ${SIP_EXECUTABLE} -t ALL -x VendorID -t WS_X11 -x PyQt_NoPrintRangeBug -t Qt_4_3_0 -g -t KDE_3_92_0 -j 1 -c ${CMAKE_CURRENT_BINARY_DIR}/${_module_path} ${_sip_includes} ${_abs_module_sip}
        DEPENDS ${_abs_module_sip}
    )
    ADD_LIBRARY(${_logical_name} SHARED ${CMAKE_CURRENT_BINARY_DIR}/${_module_path}/sip${_child_module_name}part0.cpp)
    TARGET_LINK_LIBRARIES(${_logical_name} ${PYTHON_LIBRARY})
    TARGET_LINK_LIBRARIES(${_logical_name} ${EXTRA_LINK_LIBRARIES})
    SET_TARGET_PROPERTIES(${_logical_name} PROPERTIES PREFIX "" OUTPUT_NAME ${_child_module_name})

    INSTALL(TARGETS ${_logical_name} DESTINATION ${PYTHON_SITE_PACKAGES_DIR}/${_parent_module_path})

ENDMACRO(ADD_SIP_PYTHON_MODULE)

###########################################################################

INCLUDE_DIRECTORIES(
    ${PYTHON_INCLUDE_DIR}
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

SET(SIP_INCLUDES ${PYQT_SIP_DIR} sip)

ADD_DEFINITIONS(-D_KDEPRINT_COMPILE -D_REENTRANT -DQT_NO_DEBUG -DQT_CORE_LIB -DQT_GUI_LIB)

ADD_SIP_PYTHON_MODULE(PyKDE4.kdecore sip/kdecore/kdecoremod.sip ${KDE4_KDECORE_LIBS} ${KDE4_KPTY_LIBS} )
ADD_SIP_PYTHON_MODULE(PyKDE4.solid sip/solid/solidmod.sip ${KDE4_SOLID_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.kdeui sip/kdeui/kdeuimod.sip ${KDE4_KDEUI_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.kio sip/kio/kiomod.sip ${KDE4_KIO_LIBS} ${KDE4_KFILE_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.kutils sip/kutils/kutilsmod.sip ${KDE4_KUTILS_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.kparts sip/kparts/kpartsmod.sip ${KDE4_KPARTS_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.ktexteditor sip/ktexteditor/ktexteditormod.sip ${KDE4_KTEXTEDITOR_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.khtml sip/khtml/khtmlmod.sip ${KDE4_KHTML_LIBS})
ADD_SIP_PYTHON_MODULE(PyKDE4.kdeprint sip/kdeprint/kdeprintmod.sip ${KDE4_KDEPRINT_LIBS})
