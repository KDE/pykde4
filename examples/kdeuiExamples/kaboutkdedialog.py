from PyQt4.QtCore import SIGNAL, Qt
from PyQt4.QtGui import QLabel

from PyKDE4.kdecore import i18n
from PyKDE4.kdeui import KVBox, KHBox, KPushButton, KHelpMenu

helpText = """The KAboutKdeDialog is the dialog that is normally
available from the help menu.

Press the button below to display the dialog.
"""

dialogName = "KAboutKdeDialog" 

class MainFrame(KVBox):

    """Class showing the use of KAboutKdeDialog."""

    def __init__(self, parent):
        KVBox.__init__(self, parent)
        self.help = QLabel (helpText, self)
        self.layout ().setAlignment (self.help, Qt.AlignHCenter)
        
        hBox = KHBox (self)
        self.button = KPushButton(i18n("Show %s" % dialogName), hBox)
        self.button.setMaximumSize (250, 30)
       
        self.helpmenu = KHelpMenu(parent, "", False)
        self.button.clicked.connect(self.helpmenu.aboutKDE)


# This example can be run standalone

if __name__ == '__main__':

    import sys
   
    from PyKDE4.kdecore import KCmdLineArgs, KAboutData, KLocalizedString, ki18n
    from PyKDE4.kdeui import KApplication, KMainWindow
    
                
    class MainWin (KMainWindow):
        def __init__ (self, *args):
            KMainWindow.__init__ (self)

            self.resize(640, 480)
            self.setCentralWidget (MainFrame (self))    
    
    #-------------------- main ------------------------------------------------
    
    appName     = "kaboutkdedialog.py"
    catalog     = ""
    programName = ki18n ("kaboutkdedialog")
    version     = "1.0"
    description = ki18n ("KAboutKdeDialog Example")
    license     = KAboutData.License_GPL
    copyright   = ki18n ("(c) 2007 Jim Bublitz")
    text        = ki18n ("none")
    homePage    = "www.riverbankcomputing.com"
    bugEmail    = "jbublitz@nwinternet.com"

    aboutData   = KAboutData (appName, catalog, programName, version, description,
                              license, copyright, text, homePage, bugEmail)

    # ki18n required for first two addAuthor () arguments
    aboutData.addAuthor (ki18n ("Troy Melhase"), ki18n ("original concept"))
    aboutData.addAuthor (ki18n ("Jim Bublitz"), ki18n ("pykdedocs"))
    
    KCmdLineArgs.init (sys.argv, aboutData)
    
    app = KApplication ()
    mainWindow = MainWin (None, "main window")
    mainWindow.show()
    app.lastWindowClosed.connect(app.quit)
    app.exec_ ()
