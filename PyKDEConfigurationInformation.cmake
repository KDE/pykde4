# This file sets up the files responsible for providing information about
# PyKDE was configured, to be used by modules built on top of it.
#
# pykdeconfig.py is legacy, and provided only when PyQt4 itself was built with
# its legacy build system (deprecated in PyQt 4.10) and thus provides
# pyqtconfig.py.
#
# pykde_config.sip.in contains SIP code for setting the
# PyKDE4.kdecore.PYKDE_CONFIGURATION dict. It is present regardless of whether
# pykdeconfig.py exists or not. Like PYQT_CONFIGURATION, it contains less
# information than pykdeconfig.py, but enough for other modules to determine
# which SIP flags were used to build PyKDE.

# Turn these variables into arguments for the sip binary.
set(_SIP_TAGS)
foreach (_TAG ${SIP_TAGS})
    set(_SIP_TAGS "${_SIP_TAGS} -t ${_TAG}")
endforeach (_TAG)
set(_SIP_X)
foreach (_X ${SIP_DISABLE_FEATURES})
    set(_SIP_X "${_SIP_X} -X ${_X}")
endforeach (_X ${SIP_DISABLE_FEATURES})

# Common variables.
set(PYKDE_SIP_DIR "${SIP_FILES_INSTALL_DIR}/PyKDE4")
set(PYKDE_SIP_FLAGS "${_SIP_TAGS} ${_SIP_X} ${SIP_EXTRA_OPTIONS}")

# Create pykde_config.sip.
configure_file(sip/kdecore/pykde_config.sip.in ${CMAKE_BINARY_DIR}/pykde_config.sip @ONLY)

# pykdeconfig.py. It is always created, but is installed only if PyQt itself
# installs pyqtconfig.py.
get_filename_component(LIB_DIR ${KDE4_LIB_DIR} NAME)
set(SIP_CONFIGURATION "
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
    'pykde_kde_sip_flags':  '${PYKDE_SIP_FLAGS}',
    'pykde_mod_dir':        '${PYTHON_SITE_PACKAGES_INSTALL_DIR}/PyKDE4',
    'pykde_modules':        '${PYKDE_MODULES}',
    'pykde_sip_dir':        '${PYKDE_SIP_DIR}',
    'pykde_version':        kde_version_hex,
    'pykde_version_str':    '${KDE_VERSION}'
}

_default_macros = None")
configure_file(pykdeconfig.py.in ${CMAKE_BINARY_DIR}/pykdeconfig.py)
