import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "PySide6 QML Birles"

    Image {
        id: liveImage               // give it an id so Timer can reference it
        fillMode: Image.PreserveAspectFit
        source: "image://cv/liveImage"   // correct image provider URL
    }


    Timer {
        interval: 30
        running: false
        repeat: false
        onTriggered: liveImage.source = "image://cv/live?" + Date.now()  // id matches
    }
    Button {
            text: "Click Me"
            anchors.centerIn: parent

            onClicked: backend.startVideo(),
            Timer.running = true,Timer.repeat=true
        }
}