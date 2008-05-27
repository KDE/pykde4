#!python
#
############################################################################
# Original C++ version is Copyright (C) 2006 Chusslove Illich <caslav.ilic@gmx.net>
# Copyright (C) 2008 Simon Edwards <simon@simonzone.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License or (at
# your option) version 3 or, at the discretion of KDE e.V. (which shall
# act as a proxy as in section 14 of the GPLv3), any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

from PyKDE4.kdecore import *
from PyKDE4.kdeui import *
from PyQt4.QtCore import *
import sys
import unittest

class I18nTests(unittest.TestCase):

    def testWarmUp(self):
        self.assert_(i18n("Daisies, daisies")=="Daisies, daisies")

    def testPlaceholderInTheMiddle(self):
        self.assert_(i18n("Fault in %1 unit", "AE35")=="Fault in AE35 unit");
        
    def testIntPlaceholder(self):
        self.assert_(i18n("Fault in unit number %1", 5)=="Fault in unit number 5");

    def testFloatPlaceholder(self):
        self.assert_(i18n("Fluid at %1l", 1.2)=="Fluid at 1.2l");
        
    def testPlaceholderAtTheStart(self):
        self.assert_(i18n("%1, Tycho Magnetic Anomaly 1", "TMA-1")=="TMA-1, Tycho Magnetic Anomaly 1")

    def testPlaceholderAtTheEnd(self):
        self.assert_(i18n("...odd things happening at %1", "Clavius")=="...odd things happening at Clavius")

    def testTwoPlaceholders(self):
        self.assert_(i18n("%1 and %2", "Bowman", "Poole")=="Bowman and Poole")
        
    def testTwoPlaceholdersInInvertedOrder(self):
        self.assert_(i18n("%2 and %1", "Poole", "Bowman")=="Bowman and Poole")

    def testPercentWhichIsNotAPlaceholder(self):
        self.assert_(i18n("It's going to go %1% failure in 72 hours.", str(100))=="It's going to go 100% failure in 72 hours.")

    def testUsualPlural(self):
        self.assert_(i18np("%1 pod", "%1 pods", 1)=="1 pod")

    def testUsualPlural2(self):
        self.assert_(i18np("%1 pod", "%1 pods", 10)=="10 pods")

    def testNoPluralNumberInSingular(self):
        self.assert_(i18np("A pod", "%1 pods", 1)=="A pod")
        
    def testNoPluralNumberInSingular2(self):
        self.assert_(i18np("A pod", "%1 pods", 10)=="10 pods")

    def testNoPluralNumberInSingularOrPlural(self):
        self.assert_(i18np("A pod", "Few pods", 1)=="A pod")
        
    def testNoPluralNumberInSingularOrPlural2(self):
        self.assert_(i18np("A pod", "Few pods", 10)=="Few pods")

    def testFirstOfTwoArgumentsAsPluralNumber(self):
        self.assert_(i18np("A pod left on %2", "%1 pods left on %2", 1, "Discovery")=="A pod left on Discovery")
        
    def testFirstOfTwoArgumentsAsPluralNumber2(self):
        self.assert_(i18np("A pod left on %2", "%1 pods left on %2", 2, "Discovery")=="2 pods left on Discovery")

    def testSecondOfTwoArgumentsAsPluralNumber(self):
        self.assert_(i18np("%1 has a pod left", "%1 has %2 pods left","Discovery", 1)=="Discovery has a pod left")
        
    def testSecondOfTwoArgumentsAsPluralNumber2(self):
        self.assert_(i18np("%1 has a pod left", "%1 has %2 pods left","Discovery", 2)=="Discovery has 2 pods left")

    def testNoPluralNumberInSingularOrPluralButAnotherArgumentPresent(self):
        self.assert_(i18np("A pod left on %2", "Some pods left on %2", 1, "Discovery")=="A pod left on Discovery")
        
    def testNoPluralNumberInSingularOrPluralButAnotherArgumentPresent2(self):    
        self.assert_(i18np("A pod left on %2", "Some pods left on %2", 2, "Discovery")=="Some pods left on Discovery")

def main():
    global kapp

    appName     = "i18ntest"
    catalog     = "i18ntest"
    programName = ki18n ("i18ntest")
    version     = "1.0.0"
    description = ki18n ("i18n test code")
    license     = KAboutData.License_GPL
    copyright   = ki18n ("(c) 2008 Simon Edwards")
    text        = ki18n ("i18n test code")
    homePage    = ""
    bugEmail    = "simon@simonzone.com"
    aboutData   = KAboutData (appName, catalog, programName, version, description,
                                license, copyright, text, homePage, bugEmail)
    backup_argv=  sys.argv[:]
    KCmdLineArgs.init(sys.argv, aboutData)
    KCmdLineArgs.StdCmdLineArgs()
    kapp = KApplication()
    sys.argv = backup_argv
    unittest.main()

if __name__ == '__main__':
    main()
