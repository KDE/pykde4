#

set(kpythonpluginfactory_SRCS
    kpythonpluginfactory.cpp)

GET_FILENAME_COMPONENT(LIB_PYTHON ${PYTHON_LIBRARY} NAME)
ADD_DEFINITIONS(-DLIB_PYTHON=\\"${LIB_PYTHON}\\")
ADD_DEFINITIONS(-DKDE_DEFAULT_DEBUG_AREA=15000)

kde4_add_plugin(kpythonpluginfactory ${kpythonpluginfactory_SRCS})
target_link_libraries(kpythonpluginfactory ${KDE4_KDECORE_LIBS} ${KDE4_KDEUI_LIBS} ${PYTHON_LIBRARY})
install(TARGETS kpythonpluginfactory DESTINATION ${PLUGIN_INSTALL_DIR})
