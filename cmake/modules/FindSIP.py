# FindSIP.py
# By Simon Edwards <simon@simonzone.com>
# This file is in the public domain.
import sys
import sipconfig

sipcfg = sipconfig.Configuration()
print("sip_version:%s" % sipcfg.sip_version)
print("sip_version_str:%s" % sipcfg.sip_version_str)
print("sip_bin:%s" % sipcfg.sip_bin)
print("sip_inc_dir:%s" % sipcfg.sip_inc_dir)
print("py_inc_dir:%s" % sipcfg.py_inc_dir)
print("py_lib_dir:%s" % sipcfg.py_lib_dir)
