import cv2
import numpy as np
class image:
    def __init__(self,videoPath):
        self.setPath(videoPath)
        self.cvImage = np.ones((900,900,3),np.uint8)
        self.images = []
        self.cannyThresh=50
        self.blurInt=5
        self.threshMax=127
    def setPath(self,path):
        self.videopPath = path
        self.cap = cv2.VideoCapture(path)
    def getNumberofVideo(self):
        return self.images.__len__()
    def getRoi(self,img,pt):
        pts = np.array(pt)
        pts = pts.reshape((4))
        print(pts)
        x1,y1,x2,y2 = pts
        cropped = img[int(y1):int(y2),int(x1):int(x2)]
        cv2.imshow(",",cropped)
        return cropped
    def processImage(self):
        b,frame = self.cap.read()
        if (b):
            self.cvImage = cv2.resize(frame,(1280,720))
            blurredImage = cv2.GaussianBlur(self.cvImage,(5,5),sigmaX=self.blurInt)
            grayScale = cv2.cvtColor(blurredImage, cv2.COLOR_RGB2GRAY)
            _,thresh = cv2.threshold(grayScale,self.threshMax,255,cv2.THRESH_BINARY)
            cannyImage = cv2.Canny(thresh,self.cannyThresh,50)
            self.images = []
            self.images.append(self.cvImage)
            self.images.append(blurredImage)
            self.images.append(grayScale)
            self.images.append(thresh)
            self.images.append(cannyImage)

            return self.cvImage
        else:
            return np.ones((600,600,3),np.uint8)
        
