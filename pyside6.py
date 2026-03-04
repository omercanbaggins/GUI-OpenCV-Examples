# pyqt5_video.py
import sys
from PyQt5.QtWidgets import QApplication, QLabel, QWidget, QVBoxLayout, QPushButton
from PyQt5.QtCore import QTimer
from PyQt5.QtGui import QPixmap, QImage
import cv2

videoPaths = ("wp.mp4","example.mp4")

class VideoPlayer(QWidget):
    def __init__(self, video_path):
        super().__init__()
        self.videoIndex=0
        self.setWindowTitle("PyQt5 Video Player")
        self.video_path = video_path

        self.layout = QVBoxLayout()
        self.label = QLabel("Video yükleniyor...")
        self.layout.addWidget(self.label)

        self.button = QPushButton("Başlat")
        self.button.clicked.connect(self.toggle_video)
        self.layout.addWidget(self.button)

        self.setLayout(self.layout)

        self.cap = cv2.VideoCapture(self.video_path)
        self.timer = QTimer()
        self.timer.timeout.connect(self.next_frame)

        self.NextButton = QPushButton("nextVideo")
        self.NextButton.clicked.connect(lambda:(setattr(self,"videoIndex",self.videoIndex+1),setattr(self,"cap",cv2.VideoCapture(videoPaths[self.videoIndex]))))

        self.prevButton = QPushButton("lastvideo")
        self.prevButton.clicked.connect(lambda:(setattr(self,"videoIndex",self.videoIndex-1),setattr(self,"cap",cv2.VideoCapture(videoPaths[self.videoIndex]))))

        self.layout.addWidget(self.NextButton)
        self.layout.addWidget(self.prevButton)
        self.playing = False


    def toggle_video(self):
        if not self.playing:
            self.timer.start(30)

            self.button.setText("Durdur")
        else:
            self.timer.stop()
            self.button.setText("Başlat")
        self.playing = not self.playing

    def next_frame(self):
        ret, frame = self.cap.read()
        if ret:
            frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            h, w, ch = frame.shape
            bytes_per_line = ch * w
            qt_image = QImage(frame.data, w, h, bytes_per_line, QImage.Format_RGB888)
            self.label.setPixmap(QPixmap.fromImage(qt_image))
        else:
            self.cap.set(cv2.CAP_PROP_POS_FRAMES, 0)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    player = VideoPlayer(videoPaths[0])
    player.resize(640, 480)
    player.show()
    sys.exit(app.exec_())