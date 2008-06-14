import sys,  os.path
from random import randint

from PyQt4.QtCore import Qt
from PyQt4.QtGui import QPixmap, QLabel

from PyKDE4.kdecore import i18n
from PyKDE4.kdeui import KVBox, KHBox

imagePath = sys.path [0]

helpText = """There is no example for this widget or class.

Write a short example program (see "Contributing to PyKDE4")
and become famous, respected and more familiar with PyKDE.

(You can make the Doc tab focus instead of the Sample tab 
by changing the "Favor" setting in the settings dialog")
"""

class MainFrame(KVBox):
    def __init__(self, parent = None):
        KVBox.__init__(self, parent)
        self.help  = QLabel (helpText, self)
        self.layout ().setAlignment (self.help, Qt.AlignHCenter)
        self.setMargin (40)
        
        # choose an image at random
        self.pix   = QPixmap (os.path.join (imagePath, "poster%i.png" % randint (0, 6)))

        hBox = KHBox (self)
        self.poster = QLabel (hBox)
        self.poster.setPixmap (self.pix)

        self.layout ().setAlignment (hBox, Qt.AlignHCenter)
        self.setStretchFactor (hBox, 1)


# This example can be run standalone

if __name__ == '__main__':

    import sys

    from PyQt4.QtCore import SIGNAL
   
    from PyKDE4.kdecore import KCmdLineArgs, KAboutData, KLocalizedString, ki18n
    from PyKDE4.kdeui import KApplication, KMainWindow
    
                
    class MainWin (KMainWindow):
        def __init__ (self, *args):
            KMainWindow.__init__ (self)

            self.resize (640, 600)
            self.setCentralWidget (MainFrame (self))
            
    
    #-------------------- main ------------------------------------------------
    
    appName     = "default"
    catalog     = ""
    programName = ki18n ("default")                 #ki18n required here
    version     = "1.0"
    description = ki18n ("Default Example")         #ki18n required here
    license     = KAboutData.License_GPL
    copyright   = ki18n ("(c) 2007 Jim Bublitz")    #ki18n required here
    text        = ki18n ("none")                    #ki18n required here
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
    mainWindow.show ()
    app.connect (app, SIGNAL ("lastWindowClosed ()"), app.quit)
    app.exec_ ()
