#!python
# -*- coding: utf-8 -*-
# ***************************************************************************
# *   Copyright (C) 2008 Daniel Nicoletti <dantti85-pk@yahoo.com.br>        *
# *   Copyright (C) 2009 Simon Edwards <simon@simonzone.com>                *
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# *   This program is distributed in the hope that it will be useful,       *
# *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
# *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
# *   GNU General Public License for more details.                          *
# *                                                                         *
# *   You should have received a copy of the GNU General Public License     *
# *   along with this program; if not, write to the                         *
# *   Free Software Foundation, Inc.,                                       *
# *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
# ***************************************************************************
from PyQt4.QtCore import *
from PyKDE4.polkitqt import *
import dbus
import dbus.service
import dbus.mainloop.qt
import sys

class PkExampleHelperApplication(QCoreApplication):
    def __init__(self,argv):
        QCoreApplication.__init__(self,argv)
        print("Creating Helper")

        system_bus = dbus.SystemBus()
        self.name = dbus.service.BusName("org.qt.policykit.examples", system_bus)
        self.service = PkExampleService(system_bus, '/')

#    // Normally you will set a timeout so your application can
#    // free some resources of the poor client machine ;)
#    QTimer::singleShot(MINUTE, this, SLOT(quit()));

class PkExampleService(dbus.service.Object):

    @dbus.service.method("org.qt.policykit.examples", in_signature='s',
            out_signature='s', sender_keyword='sender')
    def play(self, user, sender=None):
        print("Calling user: "+str(user))
        print("sender: " + str(sender))

        # here you need to notice two important things:
        # 1st 'sender' is the service name of the caller
        #     with it we can check if the caller is authorized to
        #     do the following action
        # 2nd the "true" parameter, this is REALLY important, you MUST
        #     allways set it to true if you are in the helper. This way
        #     one shot actions can be properly revoked, use "true" even
        #     if your action aren't one shot, since they can easyly changed
        #     by any PolicyKit Authorization application.
        result = PolkitQt.Auth.isCallerAuthorized("org.qt.policykit.examples.play", sender, True)
        print("result: "+str(result))
        if result == PolkitQt.Auth.Yes:
            print(str(user) + " can play")
            return str(user) + " can play"
        else:
            print("Sorry " + str(user) + " can not play")
            return "Sorry " + str(user) + " can not play"

def main():
    dbus.mainloop.qt.DBusQtMainLoop(set_as_default=True)
    example = PkExampleHelperApplication(sys.argv)
    return example.exec_();
main()
