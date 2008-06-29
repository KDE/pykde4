# A Sample PyKDE4 project which uses cmake fo installation.
#
# By Simon Edwards <simon@simonzone.com>
# This file is in the public domain.

SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules )

# The name of the project
project(sample_project) # FIXME this is currently a C++ project and requires a C++ compilier.
set(PROGRAM_VERSION 1.)

include (PythonMacros)
include (DistMacros)

find_package(KDE4 REQUIRED)
find_package(PyQt4 REQUIRED)
find_package(PyKDE4 REQUIRED)
find_package(GettextMsgfmt REQUIRED)

# Python files to be installed and byte compiled are specified with
# pykde4_add_files().
pykde4_install_python_files(src/sample_project.py)
pykde4_add_executable(src/sample_project.py sample_project)

# Designer Qt files to be compiled, installed and also byte compiled are
# specified with pykde4_add_ui_files().
pykde4_add_ui_files(src/sample_project_window.ui)

kde4_create_handbook(doc/en/index.docbook)

# Setup message translations
gettext_install_messages()

# Support for creating simple distribution tarball of the project.
# List of files for the 'dist' make target.
source_dist(${CMAKE_SOURCE_DIR}
#    AUTHORS
#    ChangeLog
    CMakeLists.txt
#    COPYING
#    INSTALL
#    README
#    TODO
    src/*.py
    src/*.ui
    doc/*.png
    doc/*
    cmake/*
}
