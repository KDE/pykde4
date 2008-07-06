#!/usr/bin/env python
import sys

from PyQt4.QtCore import QString

from PyKDE4.kdecore import ki18n, KAboutData, KCmdLineArgs
from PyKDE4.kdeui import KApplication, KGuiItem, KMessageBox

appName     = "helloworld"
catalog     = ""
programName = ki18n ("helloworld")
version     = "1.0"
description = ki18n ("Tutorial - First Program")
license     = KAboutData.License_GPL
copyright   = ki18n ("(c) 2007 Jim Bublitz")
text        = ki18n ("none")
homePage    = "www.riverbankcomputing.com"
bugEmail    = "jbublitz@nwinternet.com"

aboutData   = KAboutData (appName, catalog, programName, version, description,
                            license, copyright, text, homePage, bugEmail)

KCmdLineArgs.init (sys.argv, aboutData)

app = KApplication ()

guiItem = KGuiItem (QString( "Hello" ), QString(),
                    QString( "this is a tooltip" ),
                    QString( "this is a whatsthis" ))

KMessageBox.questionYesNo (None, "Hello World", "Hello", guiItem)
