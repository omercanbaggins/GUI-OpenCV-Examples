import tkinter as tk
import threading
import cv2
from PIL import Image, ImageTk

label = None
videopath = "wp.mp4"
cap = cv2.VideoCapture(videopath)
b,frame = cap.read()
frame = cv2.cvtColor(frame,cv2.COLOR_BGR2RGB)

img = Image.fromarray(frame)
def playVideo():
    global img
    while(True):
        try:
            b,frame = cap.read()
            frame = cv2.cvtColor(frame,cv2.COLOR_BGR2RGB)
            img = Image.fromarray(frame)
        except:
            pass
       
        cv2.waitKey(10)


videoThread = threading.Thread(target=playVideo)

def firstButtonCm():
    print("hello tkinter")

def getPath():
    global videopath,cap
    videopath = entry.get()
    print(entry.get())
    cap = cv2.VideoCapture(videopath)    


root = tk.Tk()
label = tk.Label(root)
entry = tk.Entry(root)
root.title="tkinter first app"
root.geometry("500x500")
tk.Entry(root)
button =tk.Button(root,text="click on me!!",command=getPath)
button.pack()

try:
    imgtk = ImageTk.PhotoImage(image=img)

    # Keep reference (VERY IMPORTANT)
    label.imgtk = imgtk

    # Update label
    label.config(image=imgtk)
except:
    print("asdddddd")
    pass
label.pack()
entry.pack()

videoThread.start()
root.mainloop()
