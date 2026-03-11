import sys
import cv2
import numpy as np
import image
from PySide6.QtCore import QTimer, Qt, QByteArray,Signal, Property,Slot
from PySide6.QtGui import QImage
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication
from PySide6.QtQuick import QQuickImageProvider

class OpenCVImageProvider(QQuickImageProvider):
    onIndexChanged = Signal()
    def __init__(self,imgObj):
        super().__init__(QQuickImageProvider.Image)
        self.imObj = imgObj
        self.cvImage = self.imObj.processImage()
        self.image = None
        self.imageIndex = 0
        self.coordinates = []
        self.Cropped = QImage()
        self.convertedImages = []

    @Slot(float,float)
    def getRoiQML(self,x,y):
        if(self.coordinates.__len__()>=2):
            croppedImg = self.imObj.getRoi(self.cvImage,self.coordinates)
            self.Cropped = self.ConvertCVImageToQML(croppedImg)
            self.coordinates = []
        else:
            self.coordinates.append((x,y))
    @Slot(int)
    def setThreshMax(self,a=int):
            self.imObj.threshMax =a

    @Slot(int)
    def setBlurIntensity(self,a=int):
            self.imObj.blurInt =a
             
    @Slot(int)
    def setCannyThresh(self,a):

            self.imObj.cannyThresh =a

    def setIndex(self,i):
        len = list(self.imObj.images).__len__()
        if(len==1 or len == 0):
            self.imageIndex = 0
            return
        self.imageIndex = (self.imageIndex+i)%len
        self.onIndexChanged.emit()

    textIndex = Property(int,fset=setIndex,notify=onIndexChanged)
    def requestImage(self, id, size, requestedSize):
        if "live" in id:
            if self.image is None:
                return QImage()
            else:
                return self.convertedImages[(self.imageIndex%5)]
        # Handle the four corner images
        elif "TR" in id and self.convertedImages[0] is not None:
            return self.convertedImages[(self.imageIndex+1)%5]  # Top-Right

        elif "BR" in id and self.convertedImages[1] is not None:
            return self.convertedImages[(self.imageIndex+2)%5]  # Bottom-Right

        elif "TL" in id and self.convertedImages[2] is not None:
            return self.convertedImages[(self.imageIndex+3)%5]  # Top-Left

        elif "BL" in id and self.convertedImages[4] is not None:
            return self.convertedImages[(self.imageIndex+4)%5]  # Bottom-Left

        else:
            return QImage()
       
        
         
        
    def ConvertCVImageToQML(self,img):
        cv_img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        h, w, ch = cv_img_rgb.shape
        bytes_per_line = ch * w
        return QImage(cv_img_rgb.data, w, h, bytes_per_line, QImage.Format_RGB888).copy()

    def update_image(self):
        # Convert OpenCV BGR to RGB
        self.convertedImages = []
        self.imObj.processImage()
        self.cvImage = self.imObj.images[self.imageIndex]
        self.image = self.ConvertCVImageToQML(self.cvImage)
        for img in self.imObj.images:
             self.convertedImages.append(self.ConvertCVImageToQML(img))
        