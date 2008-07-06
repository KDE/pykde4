#!/usr/bin/env python
import sys

from PyQt4.QtCore import QString

from PyKDE4.kdecore import ki18n, KAboutData, KCmdLineArgs
from PyKDE4.kdeui import KApplication, KXmlGuiWindow, KTextEdit


class MainWindow (KXmlGuiWindow):
    def __init__ (self):
        KXmlGuiWindow.__init__ (self)

        textArea =  KTextEdit ();
        self.setCentralWidget(textArea);
        self.setupGUI()

#--------------- main ------------------

appName     = "KXmlGuiWindow"
catalog     = ""
programName = ki18n ("KXmlGuiWindow")
version     = "1.0"
description = ki18n ("Tutorial - Third Program")
license     = KAboutData.License_GPL
copyright   = ki18n ("(c) 2007 Jim Bublitz")
text        = ki18n ("none")
homePage    = "www.riverbankcomputing.com"
bugEmail    = "jbublitz@nwinternet.com"

aboutData   = KAboutData (appName, catalog, programName, version, description,
                            license, copyright, text, homePage, bugEmail)

    
KCmdLineArgs.init (sys.argv, aboutData)
    
app = KApplication ()

#------- new stuff added here ----------

mainWindow = MainWindow ()
mainWindow.show ()
app.exec_ ()
