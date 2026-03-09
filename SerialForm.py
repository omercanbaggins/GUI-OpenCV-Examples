import serialHandler
import serial
import sys
from PySide6.QtWidgets import QApplication, QVBoxLayout,QMainWindow,QLabel,QWidget
from PySide6.QtUiTools import QUiLoader
from PySide6.QtCore import QFile,QTimer


class SerialForm(QWidget):
    def __init__(self,uiFile):
        super().__init__()

        self.loader =QUiLoader()
        self.uiFile = self.loader.load(uiFile)
        self.uiFile.AddCommunicator.clicked.connect(self.addToList)
        self.DataTimer = QTimer()
        self.currentCom = None
    def addToList(self):
        print("selam aga")
        portName = self.uiFile.portInput.text()
        newPort = serialHandler.serialCommunicator("asd",portName,9600)
        self.OnListUpdated()
        serialHandler.SerialHandler.addSerialCom(newPort)
    def getData(self):
        text = str(self.currentCom.currentData)
        self.uiFile.propertyWindow.setText(text)
    def OnListUpdated(self):
        print("hello")
        self.currentCom = serialHandler.SerialHandler.SerialComs[-1]
        if(self.currentCom is not None):
            print(self.currentCom.currentData)
            self.currentCom.dataDelegateBindings.append((self,self.getData))
            self.DataTimer.timeout.connect(self.currentCom.getData)
            self.DataTimer.start(500)

