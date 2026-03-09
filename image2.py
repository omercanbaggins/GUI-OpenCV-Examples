import sys
import cv2
import numpy as np
import image
from PySide6.QtCore import QTimer, Qt, QByteArray
from PySide6.QtGui import QImage
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication
from PySide6.QtQuick import QQuickImageProvider

class OpenCVImageProvider(QQuickImageProvider):
    def __init__(self,imgObj):
        super().__init__(QQuickImageProvider.Image)
        self.imObj = imgObj
        self.cvImage = self.imObj.processImage()
        self.image = None

    def requestImage(self, id, size, requestedSize):
        if self.image is None:
            return QImage()
        else:
            return self.image

    def update_image(self):
        # Convert OpenCV BGR to RGB
        self.cvImage = self.imObj.processImage()
        cv_img_rgb = cv2.cvtColor(self.cvImage, cv2.COLOR_BGR2RGB)

        h, w, ch = cv_img_rgb.shape
        bytes_per_line = ch * w
        self.image = QImage(cv_img_rgb.data, w, h, bytes_per_line, QImage.Format_RGB888).copy()