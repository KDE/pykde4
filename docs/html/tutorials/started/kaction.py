#!/usr/bin/env python
import sys, os.path

from PyQt4.QtCore import QString, SIGNAL, Qt, QSize

from PyKDE4.kdecore import ki18n, KAboutData, KCmdLineArgs, i18n
from PyKDE4.kdeui import KApplication, KXmlGuiWindow, KTextEdit, KAction
from PyKDE4.kdeui import KStandardAction, KIcon


class MainWindow (KXmlGuiWindow):
    def __init__ (self):
        KXmlGuiWindow.__init__ (self)

        self.textArea =  KTextEdit ()
        self.setCentralWidget(self.textArea)

        self.setupActions()
        
    def setupActions (self):
        clearAction = KAction(KIcon("edit-clear"), i18n("Clear"), self)
        self.actionCollection().addAction("clear", clearAction)
        self.connect (clearAction, SIGNAL ("triggered(bool)"), self.textArea.clear)

        KStandardAction.quit (app.quit, self.actionCollection())

        self.setupGUI(QSize (600, 400), KXmlGuiWindow.Default, os.path.join (sys.path [0],"kactionui.rc"))
      
#--------------- main ------------------

appName     = "KAction"
catalog     = ""
programName = ki18n ("KAction")
version     = "1.2"
description = ki18n ("Tutorial - Fourth Program")
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
