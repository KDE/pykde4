# FindPyKDE4
#
# Checks that Python and PyKDE4 are installed and defines a couple macros:
#     * PYKDE4_ADD_FILES
#     * PYKDE4_ADD_UI_FILES
#
# By Simon Edwards <simon@simonzone.com>
# This file is in the public domain.

INCLUDE (FindPythonInterp)

EXECUTE_PROCESS(COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_SOURCE_DIR}/cmake/modules/FindPyKDE4.py OUTPUT_VARIABLE pykde_config)
IF(NOT pykde_config)
  # Failure to run
  MESSAGE(FATAL_ERROR "PyKDE4 not found")
ENDIF(NOT pykde_config)

STRING(REGEX REPLACE ".*\npykde_version:([^\n]+).*$" "\\1" PYKDE4_VERSION ${pykde_config})
STRING(REGEX REPLACE ".*\npykde_version_str:([^\n]+).*$" "\\1" PYKDE4_VERSION_STR ${pykde_config})
MESSAGE(STATUS "Found PyKDE4 version ${PYKDE4_VERSION_STR}")

FIND_PROGRAM(PYKDE4_PYKDEUIC_EXE pykdeuic4 PATHS)# ${PYKDE4_BIN_DIR})
IF(NOT PYKDE4_PYKDEUIC_EXE)
    MESSAGE(FATAL_ERROR "ERROR: Could not find pykdeuic4 (part of PyKDE4)")
ENDIF(NOT PYKDE4_PYKDEUIC_EXE)

IF(NOT SHARE_INSTALL_PREFIX)
    SET(SHARE_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/share)
ENDIF(NOT SHARE_INSTALL_PREFIX)

IF(NOT DATA_INSTALL_DIR)
    SET(DATA_INSTALL_DIR ${SHARE_INSTALL_PREFIX}/apps)
ENDIF(NOT DATA_INSTALL_DIR)

MACRO(PYKDE4_ADD_FILES)

    ADD_CUSTOM_TARGET(pysupport ALL)
    FOREACH (_current_FILE ${ARGN})

        # Install the source file.
        INSTALL(FILES ${_current_FILE} DESTINATION ${DATA_INSTALL_DIR}/${PROJECT_NAME})

        # Byte compile and install the .pyc file.        
        GET_FILENAME_COMPONENT(_absfilename ${_current_FILE} ABSOLUTE)
        GET_FILENAME_COMPONENT(_filename ${_absfilename} NAME)
        GET_FILENAME_COMPONENT(_filenamebase ${_absfilename} NAME_WE)
        GET_FILENAME_COMPONENT(_basepath ${_absfilename} PATH)
        SET(_bin_py ${CMAKE_BINARY_DIR}/${_basepath}/${_filename})
        SET(_bin_pyc ${CMAKE_BINARY_DIR}/${_basepath}/${_filenamebase}.pyc)

        FILE(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${_basepath})
        ADD_CUSTOM_COMMAND(
            TARGET pysupport
            COMMAND ${CMAKE_COMMAND} -E copy ${_absfilename} ${_bin_py}
            COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_SOURCE_DIR}/cmake/modules/PythonCompile.py ${_bin_py}
            DEPENDS ${_absfilename}
        )
        INSTALL(FILES ${_bin_pyc} DESTINATION ${DATA_INSTALL_DIR}/${PROJECT_NAME})

    ENDFOREACH (_current_FILE)
ENDMACRO(PYKDE4_ADD_FILES)

MACRO(PYKDE4_ADD_UI_FILES)

    ADD_CUSTOM_TARGET(pysupport ALL)
    FOREACH (_current_FILE ${ARGN})

        # Convert to .py and byte compile.
        GET_FILENAME_COMPONENT(_absfilename ${_current_FILE} ABSOLUTE)
        GET_FILENAME_COMPONENT(_filename ${_absfilename} NAME)
        GET_FILENAME_COMPONENT(_filenamebase ${_absfilename} NAME_WE)
        GET_FILENAME_COMPONENT(_basepath ${_absfilename} PATH)
        SET(_bin_py ${CMAKE_BINARY_DIR}/${_basepath}/${_filenamebase}_ui.py)
        SET(_bin_pyc ${CMAKE_BINARY_DIR}/${_basepath}/${_filenamebase}_ui.pyc)

        FILE(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${_basepath})
        ADD_CUSTOM_COMMAND(
            TARGET pysupport
            COMMAND ${PYKDE4_PYKDEUIC_EXE} -o ${_bin_py} ${_absfilename}
            COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_SOURCE_DIR}/cmake/modules/PythonCompile.py ${_bin_py}
            DEPENDS ${_absfilename}
        )
        INSTALL(FILES ${_bin_py} DESTINATION ${DATA_INSTALL_DIR}/${PROJECT_NAME})
        INSTALL(FILES ${_bin_pyc} DESTINATION ${DATA_INSTALL_DIR}/${PROJECT_NAME})

    ENDFOREACH (_current_FILE)
ENDMACRO(PYKDE4_ADD_UI_FILES)
