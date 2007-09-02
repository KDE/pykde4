# Copyright (c) 2004
#   Riverbank Computing Limited <info@riverbankcomputing.co.uk>
#   Jim Bublitz <jbublitz@nwinternet.com>
#
# This file is part of PyKDE.
#
# This copy of PyKDE is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 2, or (at your option) any later
# version.
#
# PyKDE is supplied in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# PyKDE; see the file LICENSE.  If not, write to the Free Software Foundation,
# Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# This module is intended to be used by the configuration scripts of extension
# modules that %Import PyKDE modules.


import sipconfig, PyQt4.pyqtconfig


# These are installation specific values created when PyKDE was configured.
_pkg_config = {
    'dist_name':            '',
    'kde_version':          0x039300,
    'kde_version_extra':    'kde3930',
    'kde_version_sfx':      '-kde3930.diff',
    'kde_version_str':      '3.93.0',
    'kdebasedir':           '/home/sbe/devel/kde4install',
    'kdeincdir':            '/home/sbe/devel/kde4install/include',
    'kdelibdir':            '/home/sbe/devel/kde4install/lib',
    'konsolepart':          'False',
    'libdir':               'lib',
    'pykde_kde_sip_flags':  '-t ALL -x VendorID -t WS_X11 -x PyQt_NoPrintRangeBug -t Qt_4_3_0 -g -t KDE_3_92_0',
    'pykde_mod_dir':        '/home/sbe/devel/kde4install/lib/python2.5/site-packages/PyKDE4',
    'pykde_modules':        'kdecore solid kdefx kdeui kio kutils kparts ktexteditor khtml kdeprint',
    'pykde_sip_dir':        '/home/sbe/devel/kde4install/share/sip',
    'pykde_version':        0x039200,
    'pykde_version_str':    '3.92.0'
}

_default_macros = None



class Configuration(PyQt4.pyqtconfig.Configuration):
    """The class that represents PyQt configuration values.
    """
    def __init__(self, sub_cfg=None):
        """Initialise an instance of the class.

        sub_cfg is the list of sub-class configurations.  It should be None
        when called normally.
        """
        if sub_cfg:
            cfg = sub_cfg
        else:
            cfg = []

        cfg.append(_pkg_config)

        PyQt4.pyqtconfig.Configuration.__init__(self, cfg)


class KdecoreModuleMakefile(PyQt4.pyqtconfig.QtCoreModuleMakefile):
    """The Makefile class for modules that %Import kdecore.
    """
    def finalise(self):
        """Finalise the macros.
        """

        PyQt4.pyqtconfig.QtCoreModuleMakefile.finalise(self)

class SolidModuleMakefile(KdecoreModuleMakefile):
    """The Makefile class for modules that %Import kdesu.
    """
    def finalise(self):
        """Finalise the macros.
        """

        KdecoreModuleMakefile.finalise(self)

class KdefxModuleMakefile(SolidModuleMakefile):
    """The Makefile class for modules that %Import kdefx.
    """
    def finalise(self):
        """Finalise the macros.
        """
        
        SolidModuleMakefile.finalise(self)

class KdeuiModuleMakefile(KdefxModuleMakefile):
    """The Makefile class for modules that %Import kdeui.
    """
    def finalise(self):
        """Finalise the macros.
        """

        KdefxModuleMakefile.finalise(self)

class KioModuleMakefile(KdeuiModuleMakefile):
    """The Makefile class for modules that %Import kio.
    """
    def finalise(self):
        """Finalise the macros.
        """

        KdeuiModuleMakefile.finalise(self)


class KpartsModuleMakefile(KioModuleMakefile):
    """The Makefile class for modules that %Import kparts.
    """
    def finalise(self):
        """Finalise the macros.
        """

        KioModuleMakefile.finalise(self)

class KhtmlModuleMakefile(KpartsModuleMakefile):
    """The Makefile class for modules that %Import khtml.
    """
    def finalise(self):
        """Finalise the macros.
        """

        KpartsModuleMakefile.finalise(self)


class KdeprintModuleMakefile(KhtmlModuleMakefile):
    """The Makefile class for modules that %Import kdeprint.
    """
    def finalise(self):
        """Finalise the macros.
        """

        KhtmlModuleMakefile.finalise(self)
