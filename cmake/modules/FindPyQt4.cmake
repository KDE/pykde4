# Find PyQt4
# ~~~~~~~~~~
# Copyright (c) 2007, Simon Edwards <simon@simonzone.com>
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
# PyQt4 website: http://www.riverbankcomputing.co.uk/pyqt/index.php
#
# Find the installed version of PyQt4. FindPyQt4 should only be called after
# Python has been found.
#
# This file defines the following variables:
#
# PYQT4_VERSION - The version of PyQt4 found expressed as a 6 digit hex number
#     suitable for comparision as a string
#
# PYQT4_VERSION_STR - The version of PyQt4 as a human readable string.
#
# PYQT4_SIP_DIR - The directory holding the PyQt4 .sip files.

IF(PYQT4_VERSION)
  # Already in cache, be silent
  SET(PYQT4_FOUND TRUE)
ELSE(PYQT4_VERSION)

  GET_FILENAME_COMPONENT(_cmake_module_path ${CMAKE_CURRENT_LIST_FILE}  PATH)

  EXECUTE_PROCESS(COMMAND ${PYTHON_EXECUTABLE} ${_cmake_module_path}/FindPyQt.py OUTPUT_VARIABLE pyqt_config)
  IF(pyqt_config)
    STRING(REGEX REPLACE "^pyqt_version:([^\n]+).*$" "\\1" PYQT4_VERSION ${pyqt_config})
    STRING(REGEX REPLACE ".*\npyqt_version_str:([^\n]+).*$" "\\1" PYQT4_VERSION_STR ${pyqt_config})
    STRING(REGEX REPLACE ".*\npyqt_sip_dir:([^\n]+).*$" "\\1" PYQT4_SIP_DIR ${pyqt_config})
    SET(PYQT4_FOUND TRUE)
  ENDIF(pyqt_config)

  IF(PYQT4_FOUND)
    IF(NOT PYQT4_FIND_QUIETLY)
      MESSAGE(STATUS "Found PyQt4 version: ${PYQT4_VERSION_STR}")
    ENDIF(NOT PYQT4_FIND_QUIETLY)
  ELSE(PYQT4_FOUND)
    IF(PYQT4_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find Python")
    ENDIF(PYQT4_FIND_REQUIRED)
  ENDIF(PYQT4_FOUND)

ENDIF(PYQT4_VERSION)
