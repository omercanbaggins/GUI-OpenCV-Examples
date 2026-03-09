import cv2
class calbacks:
    def __init__(self,windowName,owner):
        cv2.namedWindow(windowName)
        self.points = [(33,11)]
        self.owner = owner
        self.img = self.owner.sourceImage
        cv2.setMouseCallback(windowName,self.onMouse)

    def showPoints(self):
        for p in self.points:
              print(self.points)
              cv2.circle(self.owner.sourceImage,p,12,(255,255,255),36)
            
    def onMouse(self,event,x,y,flags,param):
        if event == cv2.EVENT_LBUTTONDOWN:
            if self.points.__len__() > 3:
                print("to much object")
        
                return
            else:
                self.points.append((x,y))
                self.showPoints()
                print("added")
            



