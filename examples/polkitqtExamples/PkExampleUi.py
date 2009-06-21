# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'PkExample.ui'
#
# Created: Tue Jun  9 08:02:54 2009
#      by: PyQt4 UI code generator 4.4.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

class Ui_PkExample(object):
    def setupUi(self, PkExample):
        PkExample.setObjectName("PkExample")
        PkExample.resize(571, 480)
        self.centralwidget = QtGui.QWidget(PkExample)
        self.centralwidget.setObjectName("centralwidget")
        self.gridLayout = QtGui.QGridLayout(self.centralwidget)
        self.gridLayout.setObjectName("gridLayout")
        self.label = QtGui.QLabel(self.centralwidget)
        self.label.setScaledContents(True)
        self.label.setWordWrap(True)
        self.label.setObjectName("label")
        self.gridLayout.addWidget(self.label, 0, 0, 1, 1)
        self.label_2 = QtGui.QLabel(self.centralwidget)
        self.label_2.setWordWrap(True)
        self.label_2.setObjectName("label_2")
        self.gridLayout.addWidget(self.label_2, 0, 2, 1, 1)
        self.label_3 = QtGui.QLabel(self.centralwidget)
        self.label_3.setWordWrap(True)
        self.label_3.setObjectName("label_3")
        self.gridLayout.addWidget(self.label_3, 0, 4, 1, 1)
        self.playPB = QtGui.QPushButton(self.centralwidget)
        self.playPB.setObjectName("playPB")
        self.gridLayout.addWidget(self.playPB, 1, 0, 1, 1)
        self.cryPB = QtGui.QPushButton(self.centralwidget)
        self.cryPB.setObjectName("cryPB")
        self.gridLayout.addWidget(self.cryPB, 1, 2, 1, 1)
        self.kickPB = QtGui.QPushButton(self.centralwidget)
        self.kickPB.setObjectName("kickPB")
        self.gridLayout.addWidget(self.kickPB, 1, 4, 1, 1)
        self.label_4 = QtGui.QLabel(self.centralwidget)
        self.label_4.setWordWrap(True)
        self.label_4.setObjectName("label_4")
        self.gridLayout.addWidget(self.label_4, 3, 0, 1, 1)
        self.label_5 = QtGui.QLabel(self.centralwidget)
        self.label_5.setWordWrap(True)
        self.label_5.setObjectName("label_5")
        self.gridLayout.addWidget(self.label_5, 3, 2, 1, 1)
        self.label_6 = QtGui.QLabel(self.centralwidget)
        self.label_6.setWordWrap(True)
        self.label_6.setObjectName("label_6")
        self.gridLayout.addWidget(self.label_6, 3, 4, 1, 1)
        self.deletePB = QtGui.QPushButton(self.centralwidget)
        self.deletePB.setObjectName("deletePB")
        self.gridLayout.addWidget(self.deletePB, 4, 0, 1, 1)
        self.bleedPB = QtGui.QPushButton(self.centralwidget)
        self.bleedPB.setObjectName("bleedPB")
        self.gridLayout.addWidget(self.bleedPB, 4, 2, 1, 1)
        self.verticalLayout = QtGui.QVBoxLayout()
        self.verticalLayout.setObjectName("verticalLayout")
        self.listenPB = QtGui.QPushButton(self.centralwidget)
        self.listenPB.setCheckable(False)
        self.listenPB.setObjectName("listenPB")
        self.verticalLayout.addWidget(self.listenPB)
        self.listenCB = QtGui.QCheckBox(self.centralwidget)
        self.listenCB.setObjectName("listenCB")
        self.verticalLayout.addWidget(self.listenCB)
        self.gridLayout.addLayout(self.verticalLayout, 4, 4, 1, 1)
        self.label_7 = QtGui.QLabel(self.centralwidget)
        self.label_7.setWordWrap(True)
        self.label_7.setObjectName("label_7")
        self.gridLayout.addWidget(self.label_7, 5, 0, 1, 5)
        self.line = QtGui.QFrame(self.centralwidget)
        self.line.setFrameShape(QtGui.QFrame.VLine)
        self.line.setFrameShadow(QtGui.QFrame.Sunken)
        self.line.setObjectName("line")
        self.gridLayout.addWidget(self.line, 0, 1, 1, 1)
        self.line_2 = QtGui.QFrame(self.centralwidget)
        self.line_2.setFrameShape(QtGui.QFrame.VLine)
        self.line_2.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_2.setObjectName("line_2")
        self.gridLayout.addWidget(self.line_2, 3, 1, 1, 1)
        self.line_3 = QtGui.QFrame(self.centralwidget)
        self.line_3.setFrameShape(QtGui.QFrame.VLine)
        self.line_3.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_3.setObjectName("line_3")
        self.gridLayout.addWidget(self.line_3, 3, 3, 1, 1)
        self.line_4 = QtGui.QFrame(self.centralwidget)
        self.line_4.setFrameShape(QtGui.QFrame.VLine)
        self.line_4.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_4.setObjectName("line_4")
        self.gridLayout.addWidget(self.line_4, 0, 3, 1, 1)
        self.line_5 = QtGui.QFrame(self.centralwidget)
        self.line_5.setFrameShape(QtGui.QFrame.HLine)
        self.line_5.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_5.setObjectName("line_5")
        self.gridLayout.addWidget(self.line_5, 2, 0, 1, 1)
        self.line_6 = QtGui.QFrame(self.centralwidget)
        self.line_6.setFrameShape(QtGui.QFrame.HLine)
        self.line_6.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_6.setObjectName("line_6")
        self.gridLayout.addWidget(self.line_6, 2, 2, 1, 1)
        self.line_7 = QtGui.QFrame(self.centralwidget)
        self.line_7.setFrameShape(QtGui.QFrame.HLine)
        self.line_7.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_7.setObjectName("line_7")
        self.gridLayout.addWidget(self.line_7, 2, 4, 1, 1)
        PkExample.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(PkExample)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 571, 24))
        self.menubar.setObjectName("menubar")
        self.menuActions = QtGui.QMenu(self.menubar)
        self.menuActions.setObjectName("menuActions")
        PkExample.setMenuBar(self.menubar)
        self.toolBar = QtGui.QToolBar(PkExample)
        self.toolBar.setToolButtonStyle(QtCore.Qt.ToolButtonTextUnderIcon)
        self.toolBar.setObjectName("toolBar")
        PkExample.addToolBar(QtCore.Qt.TopToolBarArea, self.toolBar)
        self.menubar.addAction(self.menuActions.menuAction())

        self.retranslateUi(PkExample)
        QtCore.QMetaObject.connectSlotsByName(PkExample)

    def retranslateUi(self, PkExample):
        PkExample.setWindowTitle(QtGui.QApplication.translate("PkExample", "PolicyKit-qt example", None, QtGui.QApplication.UnicodeUTF8))
        self.label.setText(QtGui.QApplication.translate("PkExample", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'DejaVu Sans\'; font-size:9pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Making the helper <span style=\" font-weight:600;\">Play</span> requires the user to authenticate. The authorization is kept for the life time of the process</p>\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">This is a <span style=\" font-weight:600;\">SPECIAL</span> method that calls our helper!</p></body></html>", None, QtGui.QApplication.UnicodeUTF8))
        self.label_2.setText(QtGui.QApplication.translate("PkExample", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'DejaVu Sans\'; font-size:9pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Making the helper <span style=\" font-weight:600;\">Cry</span> requires the user to authenticate. This is a one-shot authorization.</p></body></html>", None, QtGui.QApplication.UnicodeUTF8))
        self.label_3.setText(QtGui.QApplication.translate("PkExample", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'Liberation Sans\'; font-size:8pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:\'DejaVu Sans\'; font-size:9pt;\">Making the helper <span style=\" font-weight:600;\">Kick</span> requires a system administrator to authenticate. This instance overrides the defaults set in Action.</p></body></html>", None, QtGui.QApplication.UnicodeUTF8))
        self.playPB.setText(QtGui.QApplication.translate("PkExample", "Play!", None, QtGui.QApplication.UnicodeUTF8))
        self.cryPB.setText(QtGui.QApplication.translate("PkExample", "Cry!", None, QtGui.QApplication.UnicodeUTF8))
        self.kickPB.setText(QtGui.QApplication.translate("PkExample", "Kick... (long)", None, QtGui.QApplication.UnicodeUTF8))
        self.label_4.setText(QtGui.QApplication.translate("PkExample", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'DejaVu Sans\'; font-size:9pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Making the helper <span style=\" font-weight:600;\">Delete</span> requires a system administrator to authenticate. Once authenticated, this privilege can be retained indefinitely.</p></body></html>", None, QtGui.QApplication.UnicodeUTF8))
        self.label_5.setText(QtGui.QApplication.translate("PkExample", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'DejaVu Sans\'; font-size:9pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Making the helper <span style=\" font-weight:600;\">Bleed</span> requires the user to authenticate. Once authenticated, this privilege can be retained for the remainder of the desktop session.</p></body></html>", None, QtGui.QApplication.UnicodeUTF8))
        self.label_6.setText(QtGui.QApplication.translate("PkExample", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'Liberation Sans\'; font-size:8pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:\'DejaVu Sans\'; font-size:9pt;\">The <span style=\" font-weight:600;\">Listen</span> action demonstrates the use of PolicyKit to drive a toggleable QPushButton; it\'s an intuitive way to ask users to give up authorizations when they are done with them. E.g. the button is \'pressed in\' exactly when the authorization is held. Toggling the button means obtaining resp. revoking the authorization in question. It also demonstrates the use of ActionButtons, as the action is connected also to a checkbox.</p></body></html>", None, QtGui.QApplication.UnicodeUTF8))
        self.deletePB.setText(QtGui.QApplication.translate("PkExample", "Delete!", None, QtGui.QApplication.UnicodeUTF8))
        self.bleedPB.setText(QtGui.QApplication.translate("PkExample", "Bleed!", None, QtGui.QApplication.UnicodeUTF8))
        self.listenPB.setText(QtGui.QApplication.translate("PkExample", "Click to make changes...", None, QtGui.QApplication.UnicodeUTF8))
        self.listenCB.setText(QtGui.QApplication.translate("PkExample", "Click to make changes...", None, QtGui.QApplication.UnicodeUTF8))
        self.label_7.setText(QtGui.QApplication.translate("PkExample", "<i>Tip: try editing /etc/PolicyKit/Policy.conf and see the proxy widgets update in real-time.</i>.", None, QtGui.QApplication.UnicodeUTF8))
        self.menuActions.setTitle(QtGui.QApplication.translate("PkExample", "Actions", None, QtGui.QApplication.UnicodeUTF8))
        self.toolBar.setWindowTitle(QtGui.QApplication.translate("PkExample", "toolBar", None, QtGui.QApplication.UnicodeUTF8))

