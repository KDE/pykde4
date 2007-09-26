# A Sample PyKDE4 project which uses cmake fo installation.
#
# By Simon Edwards <simon@simonzone.com>
# This file is in the public domain.

# These first two lines are required.
SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules )
find_package(PyKDE4 REQUIRED)

# The name of the project is used in
project(sample_project NONE)

# Python files to be installed and byte compiled are specified with
# pykde4_add_files().
pykde4_install_python_files(src/sample_project.py)
pykde4_add_executable(src/sample_project.py sample_project)

# Designer Qt files to be compiled, installed and also byte compiled are
# specified with pykde4_add_ui_files().
pykde4_add_ui_files(src/sample_project_window.ui)
