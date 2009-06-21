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
from PyQt4.QtGui import *
from PyKDE4.polkitqt import *
from PkExampleUi import *
import dbus
import sys

class PkExample(QMainWindow,Ui_PkExample):
    def __init__(self,parent=None):
        QMainWindow.__init__(self,parent)
        #PkExample_ui.__init__(self)
        self.setupUi(self)

        bt = PolkitQt.ActionButton(self.playPB,"org.qt.policykit.examples.play", self)
        bt.setText("Play!")
        #bt.setAuthIcon(QPixmap(":/Icons/action-locked-default.png"))
        self.menuActions.addAction(bt)
        self.toolBar.addAction(bt)
        self.connect(bt, SIGNAL("triggered(bool)"), self.activateAction)
        self.connect(bt, SIGNAL("clicked(QAbstractButton*,bool)"), bt, SLOT("activate()"))
        self.connect(bt, SIGNAL("activated()"), self.actionActivated)

        bt = PolkitQt.ActionButton(self.cryPB,"org.qt.policykit.examples.cry", self)
        bt.setText("Cry!")
        #bt.setAuthIcon(QPixmap(":/Icons/action-locked-default.png"))
        self.menuActions.addAction(bt)
        self.toolBar.addAction(bt)
        self.connect(bt, SIGNAL("triggered(bool)"), self.activateAction)
        self.connect(bt, SIGNAL("clicked(QAbstractButton*,bool)"), bt.activate)
        self.connect(bt, SIGNAL("activated()"), self.actionActivated)
        
        bt = PolkitQt.ActionButton(self.kickPB,"org.qt.policykit.examples.kick", self)
        bt.setText("Kick!")
        bt.setNoVisible(True)
        bt.setNoEnabled(True)
        bt.setNoText("Kick (long)")
        #bt.setNoIcon(QPixmap(":/Icons/custom-no.png"))
        bt.setNoToolTip("If your admin wasn't annoying, you could do this")
        bt.setAuthVisible(True)
        bt.setAuthEnabled(True)
        bt.setAuthText("Kick... (long)")
        #bt.setAuthIcon(QPixmap(":/Icons/action-locked-default.png"))
        bt.setAuthToolTip("Only card carrying tweakers can do this!")
        # here we set the behavior of PolKitResul = Yes
        bt.setYesVisible(True)
        bt.setYesEnabled(True)
        bt.setYesText("Kick! (long)")
        #bt.setYesIcon(QPixmap(":/Icons/custom-yes.png"))
        bt.setYesToolTip("Go ahead, kick kick kick!")

        self.menuActions.addAction(bt)
        self.toolBar.addAction(bt)
        self.connect(bt, SIGNAL("triggered(bool)"), self.activateAction)
        self.connect(bt, SIGNAL("clicked(QAbstractButton*, bool)"), bt.activate)
        self.connect(bt, SIGNAL("activated()"), self.actionActivated)

        bt = PolkitQt.ActionButton(self.deletePB, "org.qt.policykit.examples.delete", self)
        bt.setText("Delete!")
        #bt.setAuthIcon(QPixmap(":/Icons/action-locked-default.png"))
        self.menuActions.addAction(bt)
        self.toolBar.addAction(bt)
        self.connect(bt, SIGNAL("triggered(bool)"), self.activateAction)
        self.connect(bt, SIGNAL("clicked(QAbstractButton*, bool)"), bt.activate)
        self.connect(bt, SIGNAL("activated()"), self.actionActivated)

        bt = PolkitQt.ActionButton(self.bleedPB, "org.qt.policykit.examples.bleed", self)
        bt.setText("Bleed!")
        #bt.setAuthIcon(QPixmap(":/Icons/action-locked-default.png"))
        self.menuActions.addAction(bt)
        self.toolBar.addAction(bt)
        self.connect(bt, SIGNAL("triggered(bool)"), self.activateAction)
        self.connect(bt, SIGNAL("clicked(QAbstractButton*, bool)"), bt.activate)
        self.connect(bt, SIGNAL("activated()"), self.actionActivated)

        bt = PolkitQt.ActionButtons([self.listenPB,self.listenCB], "org.qt.policykit.examples.listen", self)
        #bt.setIcon(QPixmap(":/Icons/action-locked.png"))
        #bt.setYesIcon(QPixmap(":/Icons/action-unlocked.png"))
        bt.setText("Click to make changes...")
        # this example is pretty diferent, here we have a checkable
        # QAbstractButton, the setCheckable(true) was set in the ui
        # file so you can see that there is no need to call
        # bt->setCheckable(true);
        # if you want a simple Action checkable you can do as
        # of above.
        self.menuActions.addAction(bt)
        self.toolBar.addAction(bt)
        self.connect(bt, SIGNAL("triggered(bool)"), self.activateCheckableAction)
        # We have here a separated slot cause we want to revoke the
        # action.
        # Be sure not to cast sender to Action if you do so
        # you will call the wrong activate slot and it won't work
        # well with checkable actions
        self.connect(bt, SIGNAL("clicked(QAbstractButton*, bool)"), self.activateCheckableAction)
        self.connect(bt, SIGNAL("activated()"), self.actionActivated)

    def activateAction(self):
        # Here we cast the sender() to an Action and call activate()
        # on it.
        # Be careful in doing the same for ActionButton won't work as expected
        # as action->activate() is calling Action::activate() and
        # not ActionButton::activate which are different.
        # You can cast then to ActionButton but be carefull
        # an Action casted to ActionButton may crash you app
        action = self.sender()
        # calling activate with winId() makes the auth dialog
        # be correct parented with your application.
        action.activate(self.winId())

    # activateCheckableAction is only here to revoke the action
    # As the slot above you might not need both of them, just
    # connect to the activat slot of an Action or ActionButton
    def activateCheckableAction(self):
        # Here we cast the sender() to an ActionButton and call activate()
        # on it.
        # You will probable want to connect it derectly to your app,
        # here we do this way since we want to revoke the action
        # if we are granted it
        action = self.sender()
        if action.isAllowed():
            action.revoke()
        else:
            # calling activate with winId() makes the auth dialog
            # be correct parented with your application.
            action.activate()

    def actionActivated(self):
        # This slot is called whenever an action is allowed
        # here you will do your dirt job by calling a helper application
        # that might erase your hardrive ;)
        action = self.sender()
        print("action: "+str(action))

        # here we don't want to do nothing if the action is listen
        if action.is_("org.qt.policykit.examples.listen"):
            print("toggled for: org.qt.policykit.examples.listen")
            return

        # this is our Special Action that after allowed will call the method
        if action.is_("org.qt.policykit.examples.play"):
            print("toggled for: org.qt.policykit.examples.play")
            bus = dbus.SystemBus()

            try:
                remoteObject = bus.get_object("org.qt.policykit.examples","/")
                print(str(remoteObject.play("Daniel Nicoletti", dbus_interface = "org.qt.policykit.examples")))
            except dbus.DBusException:
                print_exc()
                print usage
                sys.exit(1)
            return

        # As debug message says we are pretending to be the mechanism for the
        # following action, here you will actually call your DBus helper that
        # will run as root (setuid is not needed, see DBus docs).
        # In the helper application you will issue isCallerAuthorized,
        # passing the action id, the caller pid (which DBus will tell you) and
        # revokeIfOneShot = true as OneShot actions requires that the helper
        # revoke it after it sees that it's possible to do it, otherwise it
        # will work forever AND THAT IS NOT WHAT you want! If it's is simple
        # don't use oneShot in you .policy file ;)
        print("pretending to be the mechanism for action:" + str(action.actionId()))

        # note how we pass true to revokeIfOneShot - this is because we're
        # pretending to be the mechanism
        result = PolkitQt.Auth.isCallerAuthorized(action.actionId(), QCoreApplication.applicationPid(), True)
        if result == PolkitQt.Auth.Yes:
            # in the helper you will do the action
            print("caller is authorized to do:" + str(action.actionId()))
        else:
            # OR return false to the caller then the caller can ask for an auth dialog
            # or do anything else
            print("caller is NOT authorized to do:" + str(action.actionId()))

def main():
    global app
    app = QApplication(sys.argv)
    example = PkExample()
    example.show()
    app.exec_()
main()
