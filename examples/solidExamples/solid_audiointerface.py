from PyQt4.QtCore import Qt
from PyQt4.QtGui import QSizePolicy, QTreeWidget, QTreeWidgetItem, QLabel

from PyKDE4.kdecore import i18n
from PyKDE4.solid import Solid, Solid
from PyKDE4.kdeui import KVBox, KHBox, KTextEdit

helpText = """The Solid class discovers information about the hardware on a machine.

Solid.AudioInterface objects retrieve information about the sound system
on a machine.

We use Solid.Device.allDevices () to get a list of all devices, and then
filter it for Solid.AudioInterface types.
"""

class MainFrame(KVBox):
    def __init__(self, parent=None):
        KVBox.__init__(self, parent)
        self.help  = QLabel (i18n (helpText), self)
        self.layout ().setAlignment (self.help, Qt.AlignHCenter)
        self.setSpacing (10)

        audioDriverStr = {
                            Solid.AudioInterface.Alsa: "Alsa",\
                            Solid.AudioInterface.OpenSoundSystem: "Open Sound",\
                            Solid.AudioInterface.UnknownAudioDriver: "Unknown"
                         }


        audioInterfaceTypeStr = {
                                  Solid.AudioInterface.UnknownAudioInterfaceType: "Unknown",\
                                  Solid.AudioInterface.AudioControl: "Control",\
                                  Solid.AudioInterface.AudioInput: "In",\
                                  Solid.AudioInterface.AudioOutput: "Out"
                                }

        soundcardTypeStr = {
                             Solid.AudioInterface.InternalSoundcard: "Internal",\
                             Solid.AudioInterface.UsbSoundcard: "USB",\
                             Solid.AudioInterface.FirewireSoundcard: "Firewire",\
                             Solid.AudioInterface.Headset: "Headset",\
                             Solid.AudioInterface.Modem: "Modem"
                           }
        
        hBox = KHBox (self)
                
        display = QTreeWidget (hBox)
        display.setSizePolicy (QSizePolicy.Expanding, QSizePolicy.Expanding)
        display.setHeaderLabels (["Item", "Name", "Driver", "I/F Type", "Sound Card Type"])
        display.setColumnWidth (0, 300)
        display.setColumnWidth (1, 300)
        display.setColumnWidth (3, 75)

        # retrieve a list of Solid.Device for this machine
        deviceList = Solid.Device.allDevices ()

        
        # filter the list of all devices and display matching results
        # note that we never create a Solid.AudioInterface object, but
        # receive one from the 'asDeviceInterface' call
        for device in deviceList:
            if device.isDeviceInterface (Solid.DeviceInterface.AudioInterface):
                audio = device.asDeviceInterface (Solid.DeviceInterface.AudioInterface)
                devtype = audio.deviceType ()
                devstr  = []
                for key in audioInterfaceTypeStr:
                    flag = key & devtype
                    if flag:
                        devstr.append (audioInterfaceTypeStr [key])
                        
                QTreeWidgetItem (display, [device.product (),
                                           audio.name (),
                                           audioDriverStr [audio.driver ()],
                                           "/".join (devstr),
                                           soundcardTypeStr [audio.soundcardType ()]])

        
        

# This example can be run standalone

if __name__ == '__main__':

    import sys

    from PyQt4.QtCore import SIGNAL
    
    from PyKDE4.kdecore import KCmdLineArgs, KAboutData, KLocalizedString, ki18n
    from PyKDE4.kdeui import KApplication, KMainWindow
    
    
    class MainWin (KMainWindow):
        def __init__ (self, *args):
            KMainWindow.__init__ (self)

            self.resize(640, 480)
            self.setCentralWidget (MainFrame (self))
    
    
    #-------------------- main ------------------------------------------------
    
    appName     = "Solid_StorageDrive"
    catalog     = ""
    programName = ki18n ("Solid_StorageDrive")                 #ki18n required here
    version     = "1.0"
    description = ki18n ("Solid.StorageDrive Example")         #ki18n required here
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
    mainWindow.show()
    app.connect (app, SIGNAL ("lastWindowClosed ()"), app.quit)
    app.exec_ ()
