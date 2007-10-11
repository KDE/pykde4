# This script generates the PyKDE configuration and generates the Makefiles.
#
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


import sys
import os
import string
import glob
import getopt
import shutil
import py_compile
import subprocess

try:
    import sipconfig
except:
    print ("Can't find sipconfig.py (expected in sys.path)")
    print ("Have you built the correct version of sip?")
    sys.exit (-1)

try:
    import PyQt4.pyqtconfig
except:
    sipconfig.error ("Can't find pyqtconfig.py in sys.path - exiting")

# Get the SIP configuration.
sipcfg            = sipconfig.Configuration()
pyqtcfg           = PyQt4.pyqtconfig.Configuration ()

# Initialise the globals.
pykde_version      = 0x039200
pykde_version_str  = '3.92.0'
pykde_package      = "PyKDE4"

kde_version        = None
kde_version_str    = None
kde_version_sfx    = None
kde_version_extra  = None
kde_max_version    = 0x050000

sip_min_v4_version = 0x040600
qt_min_version     = 0x040300
pyqt_min_version   = 0x040200

kde_sip_flags = []

# Command line options.
if pykde_package:
    opt_pykdemoddir   = os.path.join (sipcfg.default_mod_dir, pykde_package)
    print "package", opt_pykdemoddir
else:
    opt_pykdemoddir   = sipcfg.default_mod_dir
opt_pykdesipdir   = sipcfg.default_sip_dir
opt_debug         = 0
opt_concat        = None
opt_split         = 1
opt_releasegil    = 0
opt_tracing       = 0
opt_static        = 0
opt_kdebasedir    = None
opt_kdelibdir     = None
opt_kdeincdir     = None
opt_konsolepart   = False
opt_dep_warnings  = 0
opt_libdir        = "lib"
opt_dist_name     = ""
opt_builddir      = "."

# The absolute path to the directory containing this script.
src_path = os.path.abspath(os.path.dirname(sys.argv[0]))


pykde_modules = ["kdecore", "solid", "kdeui", "kio", "kutils", "kparts", "ktexteditor", #"kate",
  "khtml", "kdeprint"]

pykde_imports = {
                 "kdecore":     ["QtCore", "QtGui", "QtNetwork"],
                 "solid":       ["QtCore", "QtGui", "kdecore"],
                 "kdeui":       ["QtCore", "QtGui", "QtXml", "QtSvg", "kdecore"],
                 "kio":         ["QtCore", "QtGui", "QtXml", "kdecore", "solid", "kdeui"],
                 "kutils":      ["QtCore", "QtGui", "QtXml", "kdecore", "kdeui"],
                 "kparts":      ["QtCore", "QtGui", "QtXml", "kdecore", "kdeui", "kio"],
                 "ktexteditor": ["QtCore", "QtGui", "QtXml", "kdecore", "kdeui", "kio", "kutils", "kparts"],
#                 "kate":        ["QtCore", "QtGui", "QtXml", "kdecore", "kdeui", "kio", "kutils", "kparts", "ktexteditor"],
                 "khtml":       ["QtCore", "QtGui", "QtXml", "kdecore", "kdeui", "kio", "kutils", "kparts"],
                 "kdeprint":    ["QtCore", "QtGui", "QtXml", "kdecore", "kdeui"]
                 }

pykde_includes = {
                  "kdecore":     ["QtCore", "QtGui", "QtNetwork", "sonnet"],
                  "solid":       ["QtCore", "QtGui", "solid"],
                  "kdeui":       ["QtCore", "QtGui", "QtXml", "QtSvg", "sonnet"],
                  "kio":         ["QtCore", "QtGui", "QtXml", "QtSvg", "solid", "kio", "kfile", "kssl"],
                  "kutils":      ["QtCore", "QtGui", "QtXml", "QtSvg", "ksettings"],
                  "kparts":      ["QtCore", "QtGui", "QtXml", "QtSvg", "solid", "kio", "kfile", "kssl", "kparts"],
                  "ktexteditor": ["QtCore", "QtGui", "QtXml", "QtSvg", "ktexteditor", "kate", "solid", "kio", "kfile", "kssl", "kparts", "ktexteditor", "kate"],
#                  "kate":        ["QtCore", "QtGui", "QtXml", "QtSvg", "kate", "ktexteditor", "solid", "kio", "kfile", "kssl", "kparts", "ktexteditor", "kate"],
                  "khtml":       ["QtCore", "QtGui", "QtXml", "QtSvg", "solid", "kio", "kfile", "kssl", "kparts", "dom"],
                  "kdeprint":    ["QtCore", "QtGui", "QtXml", "QtSvg", "kdeprint", "kdeprint/lpr"]
                  }

pykde_libs = {
              "kdecore":     ["QtCore", "QtGui", "QtNetwork", "kpty"],
              "solid":       ["QtCore", "QtGui", "kdecore"],
              "kdeui":       ["QtCore", "QtGui", "QtXml", "QtSvg", "kdecore"],
              "kio":         ["QtCore", "QtGui", "QtXml", "QtSvg", "kdecore", "solid", "kdeui", "kfile"],
              "kutils":      ["QtCore", "QtGui", "QtXml", "QtSvg", "kdecore", "kdeui"],
              "kparts":      ["QtCore", "QtGui", "QtXml", "QtSvg", "kdecore", "solid", "kdeui", "kio"],
              "ktexteditor": ["QtCore", "QtGui", "QtXml", "QtSvg", "kdecore", "solid", "kdeui", "kio", "kutils", "kparts"],
#              "kate":        ["QtCore", "QtGui", "QtXml", "QtSvg", "kdecore", "solid", "kdeui", "kio", "kutils", "kparts", "ktexteditor", "kateinterfaces"],
              "khtml":       ["QtCore", "QtGui", "QtXml", "QtSvg", "kdecore", "solid", "kdeui", "kio", "kutils", "kparts"],
              "kdeprint":    ["QtCore", "QtGui", "QtXml", "QtSvg", "kdecore", "kdeui"]
              }


"""postProcess       = {
                    "dcop":       None,
                    "kdecore":    [["-p ", "kdecore", "-o", "appQuit",  "kdecore.py"],
                                   ["-p ", "kdecore", "-o", "fixQVariant",  "kdecore.sbf"],
                                   ["-p ", "kdecore", "-o", "fixSignal",  "kdecorepart0.*"]],
#                    "kdesu":      None,
                    "kdefx":      None,
                    "kdeui":      None, #[["-p ", "kdeui", "-o", "shpix",  "sipkdeuiKSharedPixmap.cpp"]],
                    "kresources": None,
                    "kabc":       None,
                    "kio":        None,
                    "kfile":      None,
                    "kparts":     None,
                    "khtml":      None,
                    "kspell":     None,
                    "kdeprint":   None,
                    "kmdi":       None,
                    "kutils":     None #,
#                    "kspell2":    None
                    }"""

opt_startModName  = ""
opt_startmod      = 0
opt_endmod        = len (pykde_modules)

def check_gcc ():
    global opt_concat

    os.system ("gcc -dumpversion > gccvers.txt")
    m = open ('gccvers.txt', 'r')
    vers = m.read ().strip ()
    m.close ()
    os.unlink ('gccvers.txt')
    print "gcc version %s" % vers

    if opt_concat == None:
        if vers < "4.0.0" or vers >= "4.0.3":
            opt_concat = 1
        else:
            opt_concat = 0

    if opt_concat == 1:
        print "concatenating files"
    else:
        print "no concatenation"
    print

def init_and_check_sanity ():
    """ Do some initialization and check various versions and
        attributes of sip and PyQt installations
    """
    global opt_builddir
    opt_builddir = os.path.abspath(opt_builddir)

    check_gcc ()

    # Check SIP is new enough.
    if sipcfg.sip_version_str[:8] != "snapshot":
        minv = None

    if sipcfg.sip_version < sip_min_v4_version:
        sipcfg.error("This version of PyKDE requires SIP v%s or later" % sipcfg.version_to_string(minv))

    # Check SIP has Qt support enabled and check version
    if pyqtcfg.qt_version == 0:
        sipconfig.error("SIP has been built with Qt support disabled.")

    if pyqtcfg.qt_version < qt_min_version:
#        sipconfig.error("SIP has been built with an unsupported Qt version (%s)" % sipcfg.version_to_string (sipcfg.qt_version))
        sipconfig.error("SIP has been built with an unsupported Qt version")
        

    # Check PyQt version
    if pyqtcfg.pyqt_version < pyqt_min_version:
        sipcfg.error("This version of PyKDE requires PyQt v%s or later"\
            % pyqtcfg.version_to_string(pyqtcfg.pyqt_version))

    # find the libs, includes, and version info
    check_kde_installation ()

def usage(rcode = 2):
    """Display a usage message and exit.

    rcode is the return code passed back to the calling process.
    """
    print "Usage:"
    print "    python configure.py [-h] [-c] [-d dir] [-b dir] [-g] [-j #] [-k] {-L dir] [-n dir] [-o dir] [-r] [-u] [-v dir] [-w] [-x] [-z file]"
    print "where:"
    print "    -h      displays this help message"
    print "    -c      concatenates each module's C/C++ source files [default]"
    print "    -b dir  the directory to be used to build in [default current directory]"
    print "    -d dir  where the PyKDE modules will be installed [default %s]" % opt_pykdemoddir
    print "    -g      always release the GIL (SIP v3.x behaviour - default)"
    print "    -i      no concatenation of each module's C/C++ source files"
    print "    -j #    splits the concatenated C++ source files into # pieces [default 1]"
    print "    -k dir  the KDE base directory"
    print "    -L dir  the library directory name [default lib]"
    print "    -n dir  the directory containing the KDE lib files"
    print "    -o dir  the directory containing the KDE header files"
    print "    -r      generates code with tracing enabled [default disabled]"
    print "    -u      build with debugging symbols"
    print "    -v dir  where the PyKDE .sip files will be installed [default %s]" % opt_pykdesipdir
    print "    -w      turn on KDE deprecated object warnings when compiling [default off]"
    print "    -x      enable kinsole_part support (>= KDE 3.5.0)"
    print "    -z file the name of a file containing command line flags"

    sys.exit(rcode)


def inform_user(stage):
    """Tell the user the option values that are going to be used.
    """
    if stage == 0:
        print
        print "     PyKDE version %s" % pykde_version_str
        print "           -------"
        print
        sipconfig.inform ("Python include directory is %s" % sipcfg.py_inc_dir)
        sipconfig.inform ("Python version is %s" % sipconfig.version_to_string (sipcfg.py_version))
        print
        sipconfig.inform ("sip version is %s (%s)" % (sipcfg.sip_version_str,
            sipconfig.version_to_string (sipcfg.sip_version)))
        print
        sipconfig.inform ("Qt directory is %s" % pyqtcfg.qt_dir)
        sipconfig.inform ("Qt version is %s" % sipconfig.version_to_string (pyqtcfg.qt_version))
        print
        sipconfig.inform ("PyQt directory is %s" % pyqtcfg.pyqt_sip_dir)
        sipconfig.inform ("PyQt version is %s (%s)" % (pyqtcfg.pyqt_version_str,
            sipconfig.version_to_string (pyqtcfg.pyqt_version)))
        print

    elif stage == 1:
        sipconfig.inform ("KDE base directory is %s" % opt_kdebasedir)
        sipconfig.inform ("KDE include directory is %s" % opt_kdeincdir)
        sipconfig.inform ("KDE lib directory is %s" % opt_kdelibdir)
        sipconfig.inform ("lib directory is %s" % opt_libdir)

    elif stage == 2:
        sipconfig.inform ("KDE version is %s (0x%x)" % (kde_version_str, kde_version))
        print
        sipconfig.inform("Build directory is %s" % opt_builddir)
        sipconfig.inform("PyKDE modules will be installed in %s" % opt_pykdemoddir)
        sipconfig.inform("PyKDE .sip files will be installed in %s" % opt_pykdesipdir)
        print



def create_config(module, template):
    """Create the PyKDE configuration module so that it can be imported by build
    scripts.

    module is the module file name.
    template is the template file name.
    """
    sipconfig.inform("Creating %s..." % module)

    content = {
        "pykde_version":        pykde_version,
        "pykde_version_str":    pykde_version_str,
        "kde_version":          kde_version,
        "kde_version_str":      kde_version_str,
        "kde_version_sfx":      kde_version_sfx,
        "kde_version_extra":    kde_version_extra,
#        "pykde_bin_dir":        opt_pykdebindir,
        "pykde_mod_dir":        opt_pykdemoddir,
        "pykde_sip_dir":        opt_pykdesipdir,
        "pykde_modules":        pykde_modules,
        "pykde_kde_sip_flags":  kde_sip_flags,
        "kdebasedir":           opt_kdebasedir,
        "kdelibdir":            opt_kdelibdir,
        "libdir":               opt_libdir,
        "kdeincdir":            opt_kdeincdir,
        "pykde_modules":        pykde_modules,
        "dist_name":            opt_dist_name,
        "konsolepart":          opt_konsolepart
    }

    sipconfig.create_config_module(module, template, content)

def getKDEVersion (versFile):
    if not os.path.isfile (versFile):
        return

    major = None
    minor = None
    micro = None

    global kde_version, kde_version_str, kde_version_sfx, kde_version_extra

    f = open (versFile)
    l = f.readline ()
    
    ok = majorFound = minorFound = microFound = False

    while not ok and l:
        wl = string.split(l)
        if len(wl) == 3 and wl[0] == "#define":
            if wl[1] == "KDE_VERSION_MAJOR":
                major = int (string.strip (wl[2]))
                majorFound = True

            if wl[1] == "KDE_VERSION_MINOR":
                minor = int (string.strip (wl[2]))
                minorFound = True

            if wl[1] == "KDE_VERSION_RELEASE":
                micro = int (string.strip (wl[2]))
                microFound = True

        ok = majorFound and minorFound and microFound

        l = f.readline()

    f.close()

    exec ("kv = " + "0x%02i%02i%02i" % (major, minor,  micro))
    kde_version = kv

    if kde_version > kde_max_version:
      print
      sipconfig.inform ("*** True KDE version is %s -- building for KDE %s ***" % (hex (kde_version), hex (kde_max_version)))
      print
      kde_version = kde_max_version
      major       = hex ((kde_version & 0xff0000) >> 16) [ 2:]
      minor       = hex ((kde_version & 0x00ff00) >> 8) [ 2:]
      micro       = hex (kde_version & 0x0000ff) [ 2:]

    if ok:
        kde_version_str   = "%i.%i.%i" % (major, minor, micro)
        kde_version_sfx   = "-kde%i%i%i.diff" % (major, minor, micro)
        kde_version_extra = "kde%i%i%i" % (major, minor, micro)
    else:
        sipconfig.error ("KDE version not found in %s" % versFile)


def search (target, searchPath):
    if not searchPath:
        return

    path = None
    for searchEntry in searchPath:
        if os.path.isdir (searchEntry)\
            and (not target or os.path.isfile (os.path.join (searchEntry, target))):
            path = searchEntry
            break

    return path

def discoverKDE4 ():
    global opt_kdeincdir, opt_kdebasedir, opt_kdelibdir, opt_libdir

    if not opt_kdebasedir:
        opt_kdebasedir = run_command("kde4-config","--prefix").strip()

    if not opt_kdelibdir:
        libSearchPaths = []
        libSearchPaths = [os.path.join (opt_kdebasedir, "lib"), os.path.join (opt_kdebasedir, "lib64"), os.path.join (opt_kdebasedir, opt_libdir)]
#        print opt_libdir
        opt_kdelibdir  = search ("libkdecore.so", libSearchPaths)

    if not opt_kdeincdir:
        incSearchPaths = []
        incSearchPaths = [os.path.join (opt_kdebasedir, "include")]
        incSearchPaths.append (os.path.join (opt_kdebasedir, "include", "kde")) # Red Hat
        opt_kdeincdir = search ("kapplication.h", incSearchPaths)

def check_kde_installation():
    """Check the KDE installation and get the version number

    """

    # Check the KDE header files have been installed.
    discoverKDE4 ()

    if not opt_kdebasedir:
        sipconfig.error ("Couldn't locate KDE4 base directory")

    if not opt_kdeincdir:
        sipconfig.error ("Couldn't locate KDE4 include directory (%s is KDE base)" % opt_kdebasedir)

    if not opt_kdelibdir:
        sipconfig.error ("Couldn't locate KDE4 lib directory (%s is KDE base)" % opt_kdebasedir)

    kdeversion_h = os.path.join(opt_kdeincdir, "kdeversion.h")

    inform_user (1)

    if not os.access(kdeversion_h, os.F_OK):
        sipconfig.error("kdeversion.h could not be found in %s." % opt_kdeincdir)

    # Get the KDE version number.
    getKDEVersion(kdeversion_h)

    inform_user (2)

def check_distribution ():
    dist = glob.glob ("/etc/*-release")

    kde_sip_flags.append ("-t")
    kde_sip_flags.append ("ALL")
    
    for file in dist:
        if file.find ("andrake") > 0:
            kde_sip_flags.remove ("ALL")
            kde_sip_flags.append ("D_MANDRAKE")

def set_sip_flags():
    """Set the SIP platform, version and feature flags.
    """
    global kde_sip_flags

    check_distribution ()
    
    kde_sip_flags.append (pyqtcfg.pyqt_sip_flags)

    kdetags = {
        0x050000: "KDE_3_92_0",
    }

    kde_sip_flags.append("-t %s" % sipconfig.version_to_sip_tag(kde_version, kdetags, "KDE"))


def generate_code(mname, imports=None, extra_cflags=None, extra_cxxflags=None, extra_define=None, extra_include_dir=None, extra_lflags=None, extra_lib_dir=None, extra_lib=None, opengl=0, sip_flags=None):
    """Generate the code for a module.

    mname is the name of the module.
    imports is the list of PyQt/PyKDE modules that this one %Imports.
    extra_cflags is a string containing additional C compiler flags.
    extra_cxxflags is a string containing additional C++ compiler flags.
    extra_define is a name to add to the list of preprocessor defines.
    extra_include_dir is the name of a directory to add to the list of include
    directories.
    extra_lflags is a string containing additional linker flags.
    extra_lib_dir is the name of a directory to add to the list of library
    directories.
    extra_lib is the name of an extra library to add to the list of libraries.
    opengl is set if the module needs OpenGL support.
    sip_flags is the list of sip flags to use instead of the defaults.
    """
    sipconfig.inform("Generating the C++ source for the %s module..." % mname)

    try:
        shutil.rmtree(os.path.join(opt_builddir,mname))
    except:
        pass

    try:
        os.mkdir(os.path.join(opt_builddir,mname))
    except:
        sipconfig.error("Unable to create the %s directory." % mname)

    # Build the SIP command line.
    argv = [sipcfg.sip_bin]
    argv.extend(kde_sip_flags)

    if opt_concat:
        argv.append("-j")
        if mname in ["kdeui", "kio"] and opt_split == 1:
            splits = 2
        else:
            splits = opt_split
        argv.append(str(splits))

    if opt_tracing:
        argv.append("-r")

    if opt_releasegil:
        argv.append("-g")

    argv.append("-c")
    argv.append(os.path.join(opt_builddir, mname))

    buildfile = os.path.join(opt_builddir, mname, mname + ".sbf")
    argv.append("-b")
    argv.append(buildfile)

    argv.append("-I "+os.path.join(src_path,"sip"))
    argv.append("-I %s" % pyqtcfg.pyqt_sip_dir)

    pyqtInclPathSeen = 0

    # SIP assumes POSIX style path separators.
    argv.append(string.join([src_path.replace('\\','/'),"sip", mname, mname + "mod.sip"], "/"))

    #print string.join (argv)
    # finally, run SIP and generate the C++ code
    os.system (string.join(argv))


    # Check the result.
    if not os.access(buildfile, os.F_OK):
        sipconfig.error("Unable to create the C++ code.")


    # Generate the Makefile.
    sipconfig.inform("Creating the Makefile for the %s module..." % mname)

    installs = []

    if sipcfg.sip_version >= 0x040000:
        warnings = 1
    else:
        warnings = 0
        installs.append([[mname + ".py", mname + ".pyc"], opt_pykdemoddir])

    sipfiles = []

    for s in os.listdir (os.path.join (src_path, "sip", mname)):
        if s.endswith (".sip"):
            sipfiles.append(os.path.join(src_path, "sip", mname, os.path.basename(s)))


    installs.append([sipfiles, os.path.join(opt_pykdesipdir, mname)])

    makefile = sipconfig.SIPModuleMakefile(
        configuration = pyqtcfg,
        build_file = mname + ".sbf",
        dir = os.path.join(opt_builddir, mname),
        install_dir = opt_pykdemoddir,
        installs = installs,
        qt = 1,
        opengl = opengl,
        warnings = warnings,
        static = opt_static,
        debug = opt_debug
    )

    if extra_cflags:
        makefile.extra_cflags.append(extra_cflags)

    if extra_cxxflags:
        makefile.extra_cxxflags.append(extra_cxxflags)

    if opt_dep_warnings == 0:
        makefile.extra_cflags.append ("-Wno-deprecated-declarations")
        makefile.extra_cxxflags.append ("-Wno-deprecated-declarations")

    if extra_define:
        makefile.extra_defines.append(extra_define)

    makefile.extra_include_dirs.append (os.path.join (src_path, "extra", kde_version_extra))
    makefile.extra_include_dirs.append (opt_kdeincdir)
    makefile.extra_include_dirs.append (pyqtcfg.qt_inc_dir)
    if pykde_includes [mname]:
        for incdir in pykde_includes [mname]:
            makefile.extra_include_dirs.append (os.path.join (opt_kdeincdir, incdir))
            makefile.extra_include_dirs.append (os.path.join (pyqtcfg.qt_inc_dir, incdir))

    if extra_include_dir:
        makefile.extra_include_dirs.append(extra_include_dir)

    if extra_lflags:
        makefile.extra_lflags.append(extra_lflags)

    makefile.extra_lib_dirs.append (opt_kdelibdir)
    if extra_lib_dir:
        makefile.extra_lib_dirs.append(extra_lib_dir)
       
    makefile.extra_libs.append(extra_lib)
    if pykde_libs [mname]:
        for lib in pykde_libs [mname]:
            makefile.extra_libs.append (lib)
    
    if extra_lib == "kdeprint":
        makefile.extra_cflags.append ("-D_KDEPRINT_COMPILE")
        makefile.extra_cxxflags.append ("-D_KDEPRINT_COMPILE")


    if sipcfg.sip_version < 0x040000 and imports:
        # Inter-module links.
        for im in imports:
            makefile.extra_lib_dirs.insert(0, os.path.join("..", im))
            makefile.extra_libs.insert(0, makefile.module_as_lib(im))

    makefile.generate()
    print


def create_makefiles():
    """Create the additional Makefiles.
    """
    subdirs = pykde_modules[:]

    sipconfig.inform("Creating top level Makefile...")

    sipconfig.ParentMakefile(
        configuration = pyqtcfg,
        subdirs = subdirs,
        dir = opt_builddir,
        installs= [(os.path.join(src_path,"__init__.py"), opt_pykdemoddir),
            (os.path.join(opt_builddir,"pykdeconfig.py"), opt_pykdemoddir)]
    ).generate()


def fileOpts (fn):
    try:
        optfile = open (fn, 'r')
    except:
        error ("Could not open option file %s" % (fn))

    opts = []

    for line in optfile.readlines ():
        if (line [0] == '#') or (line == '\n'):
           continue
        elif line [0] == '-':
            opts.append ((line [0:2], string.strip (line [2:])))
        else:
            opts.append (("-" + line [0:1], string.strip (line [1:])))

    print 'Additional options: ',
    for opt, arg in opts:
        print "%s %s   " %(opt, arg)
    print

    return opts

def main(argv):
    """Create the configuration module module.

    argv is the list of command line arguments.
    """
    try:
        optlist, args = getopt.getopt(argv[1:], "hcb:d:gij:k:L:l:n:o:ruv:wxz:")
    except getopt.GetoptError:
        usage()

    global opt_pykdemoddir, opt_pykdesipdir
    global opt_debug, opt_concat, opt_releasegil
    global opt_split, opt_tracing, opt_startModName
    global opt_startmod, opt_endmod
    global opt_kdebasedir, opt_kdelibdir, opt_kdeincdir, opt_libdir, opt_builddir
    global pykde_modules, opt_dep_warnings, opt_dist_name
    global pykde_imports, pykde_includes, opt_konsolepart

    # Look for '-z' first and process that switch
    # (command line switches override file switches)
    for opt, arg in optlist:
        if opt == "-z":
             optlist = fileOpts (arg) + optlist
             break
        elif opt == "-h":
            usage (0)
    else:
        if args: usage()

    for opt, arg in optlist:
        if opt == "-h":
            usage(0)

        # turns on concatentation (on by default, here for consistency)
        elif opt == "-c":
            opt_concat = 1
            
        elif opt == "-b":
            opt_builddir = arg

        elif opt == "-d":
            if pykde_package:
                opt_pykdemoddir = os.path.join (arg, pykde_package)
            else:
                opt_pykdemoddir = arg
        elif opt == "-g":
            opt_releasegil = 1

        # turns off concatenation (on by default)
        elif opt == "-i":
            opt_concat = 0

        elif opt == "-j":
            try:
                opt_split = int(arg)
            except:
                usage()

        elif opt == "-k":
            opt_kdebasedir = arg

        elif opt == "-L":
            opt_libdir = arg

        # allows build of single module (-lmodule) or all modules
        # beginning at specified module (-lmodule:)
        elif opt == "-l":
            opt_startModName = arg
        elif opt == "-n":
            opt_kdelibdir = arg
        elif opt == "-o":
            opt_kdeincdir = arg
        elif opt == "-r":
            opt_tracing = 1
        elif opt == "-u":
            opt_debug = 1
        elif opt == "-v":
            opt_pykdesipdir = arg
        elif opt == "-w":
            opt_dep_warnings = 1
        elif opt == "-x":
            opt_konsolepart = True

    inform_user (0)
    init_and_check_sanity ()


    opt_endmod = len (pykde_modules)

    if opt_startModName != "":
        multiple = opt_startModName [-1] == ":"
        if multiple:
          opt_startModName = opt_startModName [:-1]
        if opt_startModName in pykde_modules:
            try:
                opt_startmod = pykde_modules.index (opt_startModName)
                if not multiple:
                    opt_endmod = opt_startmod + 1
            except:
                sipconfig.error ("%s is not a PyKDE module" % opt_startModName)

    print "PyKDE modules to be built:\n   %s\n" % string.join(pykde_modules [opt_startmod:opt_endmod])

    set_sip_flags()

    for module in pykde_modules [opt_startmod:opt_endmod]:
        if module != "kate":
            generate_code (module, pykde_imports [module], extra_lib = module)
        else:
            generate_code (module, pykde_imports [module], extra_lib = "%sinterfaces" % module)

    # Create the additional Makefiles.
    create_makefiles()

    # Install the configuration module.
    create_config(os.path.join(opt_builddir,"pykdeconfig.py"), os.path.join(src_path,"pykdeconfig.py.in"))


def reporting_msg ():
    print """
If reporting errors, paste all of the output above into your
message and post to the PyKDE mailing list at:

     mailto:    PyKDE@mats.imk.fraunhofer.de
     subscribe: http://mats.imk.fraunhofer.de/mailman/listinfo/pykde

You can redirect the output into a file (> output.txt) if needed
"""

# Run a system command and return the output.
def run_command (*args):
    return subprocess.Popen(args, stdout=subprocess.PIPE).communicate()[0]

###############################################################################
# The script starts here.
###############################################################################

if __name__ == "__main__":
    try:
        main(sys.argv)
    except SystemExit:
        reporting_msg ()
        raise
    except:
        reporting_msg ()
        print \
"""
An internal error occured.  Please report all output from the program,
including the following traceback, to the PyKDE mailing list
"""
        raise
