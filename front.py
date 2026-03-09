import sys
import image2
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import Qt, QRect, QTimer
from PySide6.QtCore import QObject, Slot
import image


#expose edilecek classlar QObject olmalı

app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
imgObj = image.image("test.mp4")
provider = image2.OpenCVImageProvider(imgObj)


class backendSide(QObject):

    def __init__(self,QMLfile,provider):
        super().__init__()

        self.QmlPath =QMLfile
        self.timer = QTimer()
        engine.rootContext().setContextProperty("backend", self)
        engine.addImageProvider("cv",provider)
        self.timer.timeout.connect(provider.update_image)
        engine.load(self.QmlPath)
    @Slot()

    def startVideo(self):
          # replace with camera frame
        self.timer.start(30)

backendObj = backendSide("main.qml",provider)

if not engine.rootObjects():


    sys.exit(-1)
sys.exit(app.exec())