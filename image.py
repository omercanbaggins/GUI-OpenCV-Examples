import cv2
import numpy as np
class image:
    def __init__(self,videoPath):
        self.setPath(videoPath)
        self.cvImage = np.ones((900,900,3),np.uint8)
        self.images = [(self.cvImage)] 
    def setPath(self,path):
        self.videopPath = path
        self.cap = cv2.VideoCapture(path)
    def getNumberofVideo(self):
        return self.images.__len__()

    def processImage(self):
        b,frame = self.cap.read()
        cv2.waitKey(10)
        if (b):
            self.cvImage = cv2.resize(frame,(1280,720))
            grayScale = cv2.cvtColor(self.cvImage, cv2.COLOR_RGB2GRAY)
            blurredImage = cv2.GaussianBlur(grayScale,(5,5),5)
            _,thresh = cv2.threshold(blurredImage,127,255,cv2.THRESH_BINARY)
            cannyImage = cv2.Canny(thresh,150,50)
            self.images = []
            self.images.append(self.cvImage)
            self.images.append(grayScale)
            self.images.append(cannyImage)
            return self.cvImage
        else:
            return np.ones((600,600,3),np.uint8)
        
