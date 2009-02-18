#!/usr/bin/env python

import sys

from PyKDE4.kdecore import *
from PyKDE4.kdeui import *
from PyKDE4.kparts import *

from PyQt4.QtGui import QLabel

class MainWindow (KMainWindow):
    def __init__ (self):
        KMainWindow.__init__(self)

        self.resize(640, 480)

        factory = KLibLoader.self().factory("katepart")
        part = factory.create(self, "KatePart")
        self.setCentralWidget(part.widget())

#--------------- main ------------------
if __name__ == '__main__':

    appName     = "katepart-example"
    catalog     = ""
    programName = ki18n("Kate Part Example")
    version     = "1.0"
    description = ki18n("Example loading a Kate Part")
    license     = KAboutData.License_GPL
    copyright   = ki18n("(c) 2009 Canonical Ltd")
    text        = ki18n("none")
    homePage    = "www.kubuntu.org"
    bugEmail    = "jriddell@ubuntu.com"
    
    aboutData   = KAboutData(appName, catalog, programName, version, description,
                                license, copyright, text, homePage, bugEmail)
            
    KCmdLineArgs.init(sys.argv, aboutData)
        
    app = KApplication()
    mainWindow = MainWindow()
    mainWindow.show()
    app.exec_()
