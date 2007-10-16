###########################################################################
# Find Python
# ~~~~~~~~~~~
# Copyright (c) 2007, Simon Edwards <simon@simonzone.com>
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
# Find the Python interpreter and related Python directories.
#
# This file defines the following variables:
# 
# PYTHON_EXECUTABLE - The path and filename of the Python interpreter.
#
# PYTHON_SHORT_VERSION - The version of the Python interpreter found,
#     excluding the patch version number. (e.g. 2.5 and not 2.5.1))
# 
# PYTHON_LONG_VERSION - The version of the Python interpreter found as a human
#     readable string.
#
# PYTHON_SITE_PACKAGES_DIR - Location of the Python site-packages directory.

IF(PYTHON_LIBRARY)
   # Already in cache, be silent
   SET(PYTHONLIBRARY_FOUND TRUE)
ELSE(PYTHON_LIBRARY)

  FIND_PACKAGE(PythonInterp REQUIRED)

  EXECUTE_PROCESS(COMMAND ${PYTHON_EXECUTABLE}  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules/FindLibPython.py OUTPUT_VARIABLE python_config)
  IF(python_config)
    STRING(REGEX REPLACE ".*exec_prefix:([^\n]+).*$" "\\1" PYTHON_PREFIX ${python_config})
    STRING(REGEX REPLACE ".*\nshort_version:([^\n]+).*$" "\\1" PYTHON_SHORT_VERSION ${python_config})
    STRING(REGEX REPLACE ".*\nlong_version:([^\n]+).*$" "\\1" PYTHON_LONG_VERSION ${python_config})
    STRING(REGEX REPLACE ".*\nsite_packages_dir:([^\n]+).*$" "\\1" PYTHON_SITE_PACKAGES_DIR ${python_config})
    FIND_LIBRARY(PYTHON_LIBRARY NAMES python${PYTHON_SHORT_VERSION} PATHS ${PYTHON_PREFIX}/lib NO_DEFAULT_PATH)
    SET(PYTHONLIBRARY_FOUND TRUE)
  ENDIF(python_config)

  IF(PYTHONLIBRARY_FOUND)
    IF(NOT PYTHONLIBRARY_FIND_QUIETLY)
      MESSAGE(STATUS "Found Python executable: ${PYTHON_EXECUTABLE}")
      MESSAGE(STATUS "Found Python version: ${PYTHON_LONG_VERSION}")
      MESSAGE(STATUS "Found Python library: ${PYTHON_LIBRARY}")
    ENDIF(NOT PYTHONLIBRARY_FIND_QUIETLY)
  ELSE(PYTHONLIBRARY_FOUND)
    IF(PYTHONLIBRARY_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find Python")
    ENDIF(PYTHONLIBRARY_FIND_REQUIRED)
  ENDIF(PYTHONLIBRARY_FOUND)

ENDIF (PYTHON_LIBRARY)
