#!/usr/bin/env python


import sys

from PyKDE4.kdecore import ki18n, KAboutData, KCmdLineArgs
from PyKDE4.kdeui import KApplication, KMainWindow


class MainWindow (KMainWindow):
    def __init__ (self):
        KMainWindow.__init__ (self)

        self.resize (640, 480)



#--------------- main ------------------

def main ():
        appName     = "KMainWindow"
        catalog     = ""
        programName = ki18n ("KMainWindow")
        version     = "1.0"
        description = ki18n ("Tutorial - Second Program")
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

if __name__ == '__main__':
    main ()
