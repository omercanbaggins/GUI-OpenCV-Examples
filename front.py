import sys
import image2
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import Qt, QRect, QTimer
from PySide6.QtCore import QObject, Slot,QUrl
import image
import serialHandler
import os
#expose edilecek classlar QObject olmalı

app = QApplication(sys.argv)
engine = QQmlApplicationEngine()

##provider is responsible to handle to get image data either from opencv or different place
##i defined this class but it is also derived from QQuickImageProvider which handles updating frame, converting it to
##compatible data structure etc.
##it has also built in requestImage method to override by child classes 


class backendSide(QObject):

    def __init__(self,QMLfile):
        super().__init__()
        imgObj = image.image("test.mp4")
        provider = image2.OpenCVImageProvider(imgObj)
        self.QmlPath =QMLfile
        self.timer = QTimer()
        self.provider = provider
        engine.rootContext().setContextProperty("backend", self)
          ##it is important to send ref because we want qml to recognize our methods
        engine.rootContext().setContextProperty("cv", self.provider)  
        engine.addImageProvider("cv",self.provider)                      
        self.timer.timeout.connect(self.provider.update_image)
        engine.load(self.QmlPath)

    @Slot(str)  ##i should marked every methods with slots() above of it to expose them to QML
    def setPath(self,path):
        if path is not None:
            local_path = QUrl(path).toLocalFile()
            self.provider.imObj.setPath(local_path)

        
    @Slot()  ##i should marked every methods with slots() above of it to expose them to QML
    def startVideo(self):
        self.timer.start(30)

    @Slot(int) 
    def setIndex(self,increment):
        self.provider.setIndex(increment)

  

backendObj = backendSide("main.qml")

if not engine.rootObjects():
    sys.exit(-1)
sys.exit(app.exec())