# FindLibPython.py
# By Simon Edwards <simon@simonzone.com>
# This file is in the public domain.
import sys
import distutils.sysconfig

print("exec_prefix:%s" % sys.exec_prefix)
print("short_version:%s" % sys.version[:3])
print("site_packages_dir:%s" % distutils.sysconfig.get_python_lib())
