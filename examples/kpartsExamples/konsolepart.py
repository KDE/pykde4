#!/usr/bin/env python                                                                   
#
# Copyright (c) 2011 Shaheed Haque (srhaque@theiet.org)
#
# This file is part of PyKDE4.
#
# PyKDE4 is free software; you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation; either version 2.1 of
# the License, or (at your option) any later version.
#
# PyKDE4 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http:www.gnu.org/licenses/>.
# 

# KTerminal is a KPart which implements KTerminalInterfaceV2. This sample
# illustrates how to use KTerminal to create an instance of konsolepart,
# and send it some things to do.
 
import sys
# Uncomment this if you are doing development, and installing the 
# work-in-progress here.
sys.path.insert(1,'/usr/local/lib/python2.7/site-packages')
from PyKDE4.kterminal import KTerminal
from PyQt4.QtCore import QStringList
from PyKDE4.kdecore import ki18n, KAboutData, KCmdLineArgs, KPluginLoader, KService
from PyKDE4.kparts import KParts
from PyKDE4.kdeui import *

class MainWindow (KMainWindow):
    def __init__ (self):
        KMainWindow.__init__(self)

        self.resize(640, 480)
        service = KService.serviceByDesktopName("konsolepart");
        factory = KPluginLoader(service.library()).factory()
        part = factory.create(self)
        part.destroyed.connect(self.deleteLater)
        self.setCentralWidget(part.widget())
        terminal = KTerminal(part).terminalInterfaceV2()
        terminal.startProgram("/bin/bash", QStringList())
        terminal.sendInput("ls -l\n");

if __name__ == '__main__':

    appName     = "konsolepart_example"
    catalog     = ""
    programName = ki18n("Konsole Part Example")
    version     = "1.0"
    description = ki18n("Example loading a Konsole Part")
    license     = KAboutData.License_GPL
    copyright   = ki18n("(c) Shaheed Haque")
    text        = ki18n("none")
    homePage    = "http://techbase.kde.org/Development/Languages/Python/PyKDE_KTerminal_Tutorial"
    bugEmail    = "srhaque@theiet.org"
    
    aboutData   = KAboutData(appName, catalog, programName, version, 
                             description, license, copyright, text, homePage,
                             bugEmail)
            
    KCmdLineArgs.init(sys.argv, aboutData)
        
    app = KApplication()
    mainWindow = MainWindow()
    mainWindow.show()
    app.exec_()
