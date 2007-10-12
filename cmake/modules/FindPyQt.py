#
import PyQt4.pyqtconfig

pyqtcfg = PyQt4.pyqtconfig.Configuration()
print("pyqt_version:%s" % pyqtcfg.pyqt_version)
print("pyqt_version_str:%s" % pyqtcfg.pyqt_version_str)
print("pyqt_sip_dir:%s" % pyqtcfg.pyqt_sip_dir)
