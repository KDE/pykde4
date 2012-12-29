
PYTHON_INSTALL(kde4.py ${PYTHON_SITE_PACKAGES_INSTALL_DIR}/PyQt4/uic/widget-plugins/ TRUE)
PYTHON_INSTALL(pykdeuic4.py ${PYTHON_SITE_PACKAGES_INSTALL_DIR}/PyQt4/uic/)
find_path(cmake_module_dir create_exe_symlink.cmake ${CMAKE_MODULE_PATH})

set(_uic_name "pykdeuic4-${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}")

# Step 1: Make symlink to a Python version-dependent name
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -DTARGET=${PYTHON_SITE_PACKAGES_INSTALL_DIR}/PyQt4/uic/pykdeuic4.py -DLINK_NAME=${BIN_INSTALL_DIR}/${_uic_name} -P ${cmake_module_dir}/create_exe_symlink.cmake)" )

if (NOT PYKDEUIC4_ALTINSTALL)
    # Step 2: Make a the generated symlink a link to "pykdeuic4"
    install(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${BIN_INSTALL_DIR}/${_uic_name} ${BIN_INSTALL_DIR}/pykdeuic4)" )
endif()

unset(_uic_name)
