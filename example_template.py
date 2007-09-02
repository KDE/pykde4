from PyQt4.QtCore import SIGNAL, Qt
from PyQt4.QtGui import QLabel

from PyKDE4.kdecore import i18n
from PyKDE4.kdeui import KVBox, KHBox

helpText = """
Put a short description here.
"""

class MainFrame(KVBox):
    def __init__(self, parent=None):
        KVBox.__init__(self, parent)
        self.help  = QLabel (helpText, self)
        self.layout ().setAlignment (self.help, Qt.AlignHCenter)
        
        hBox = KHBox (self)

# you can add anything you want here, but it should fit in
# about 800X600 or (preferably) slightly less, including the
# QLabel that displays the helpText. All widgets should have
# hBox (or some other combination of layout widgets) as their
# parent. Don't used fixed layouts (but you can force widgets
# to have min, max or fixed size) If it needs to be scrollable,
# you have to use a widget that'll do that. I prefer the import
# style above rather that from X import * - there are potential
# name clashes in PyKDE. The top level method name MUST be
# MainFrame and take only parent as an argument.
        
# if all you want to do is pop up a dialog, provide a button
# that does that - it's nicer if the dialog does something
# interactive. See the kcolorbutton.py example (KColorButton
# itself pops up a dialog that can be used to change the
# color or the KColorPatch also in the presentation)
        
# If, as in the kcolorbutton.py example, your example demos
# multiple widgets, it's not necessary to create a copy
# for each widget. For each additional widget, just create
# a .py file (named as described below) with a single line:
#
#    redirect = "otherwidget.py"
#
# Then clicking on the name for the widget(s), otherwidget.py
# will be loaded. This only works for widgets within the same
# module (eg all in kdeui, all in kdecore, etc - no path or
# dotted names in the program name - duplicate the program
# for other PyKDE modules if it applies)
#
# If your example works better running an external application
# rather than displaying it inside the framework, add the following
# global at the top of your program:
#
#   runner = True
#
# It actually makes no difference what value you assign to "runner".
# The framework just checks for its presence, and displays a panel
# with your help text and a button to launch the program (it uses
# subprocess.Popen (sys.executable, yourprogram.py). No allowance
# has been made for passing arguments - it could be done but it
# adds complexity both to the framework and the user interface.
#
# The framework will also display (in a separate tab) the source
# file, along with a button to allow users to save the file to
# a subdirectory where they can modify/play with it (it's expected
# all examples will reside in a subdiriectory owned by root, and be
# read-only).

# The name of the file should be the same as the name of the class
# it demos, but all lower case with a .py extension. For dotted names
# replace dots with underscores. For example, Solid.Device would
# be demo'd with a file named solid_device.py
        
# The demo program should also run standalone, and the code below
# will allow that. It's easier to debug that way too, and if the user
# saves the file to their own space, they can run it right away.

# Change the arguments to KAboutData as appropriate (be sure to list
# yourself as author!)

# You own any example code you write, so choose whatever license you
# prefer, and add any notices/text you want, preferably at the bottom.
# The only requirement is that PyKDE be able to freely distribute
# your example code (otherwise it serves no purpose), including
# packaging it with Linux distributions. Use my email address for
# bugemail if you don't want to expose yours. You can remove or change
# the addAuthor calls. The framework will probably display the author's
# name when it isn't me, but hasn't been modified to do that yet.

# I may edit example code for style, appearance or even function,
# but I won't change the author/license info (unless you ask me to).

# Add any comments you think clarify what your program does.

# Leave the comments below the line in place.

#-------------------------------------------------------------------

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
    
    appName     = "default"
    catalog     = ""
    programName = ki18n ("default")                 #ki18n required here
    version     = "1.0"
    description = ki18n ("Default Example")         #ki18n required here
    license     = KAboutData.License_GPL
    copyright   = ki18n ("(c) 2007 Jim Bublitz")    #ki18n required here
    text        = ki18n ("none")                    #ki18n required here
    homePage    = "www.riverbank.com"
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
    app.connect (app, SIGNAL ("lastWindowClosed ()"), app.quit)
    app.exec_ ()
