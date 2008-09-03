#
from PyQt4.QtGui import *
from PyKDE4.kdecore import *
from PyKDE4.kdeui import *

class PyKcm(KCModule):
    def __init__(self, component_data, parent):
        print("PyKcm constructor")
        KCModule.__init__(self,component_data, parent)
        print("PyKcm constructor done")
        self.hello = QLabel("Hello kcmodule world from Python",self)

print("Loading pykcm.py")

def CreatePlugin(widget_parent, parent, component_data):
    print("WIdget parent:"+repr(widget_parent))
    print(r"\o/ Yippie! it kind of works!")
    print("component data: " +repr(component_data))
    return PyKcm(component_data, widget_parent)
