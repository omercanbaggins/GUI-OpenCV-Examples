import tkinter as tk
import threading
import cv2


videopath = None
cap = None
def playVideo():
    while(True):
        try:
            b,frame = cap.read()

            cv2.imshow("asd",frame)
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
entry = tk.Entry(root)
root.title="tkinter first app"
root.geometry("500x500")
tk.Entry(root)
button =tk.Button(root,text="click on me!!",command=getPath)
button.pack()
label1 = tk.Label(root, text="Top")
label1.pack()
entry.pack()

videoThread.start()
root.mainloop()
