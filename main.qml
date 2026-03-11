import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Dialogs
import QtGraphs
import Qt5Compat.GraphicalEffects
ApplicationWindow {
    visible: true
    title: "PySide6 QML Birles"
    width:1920
    height:1080
    Image{
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:/images/my_background.jpg" 
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    FastBlur {
        anchors.fill: backgroundImage
        source: backgroundImage // Tell the blur what to look at
        radius: 1233 // Adjust this number for more or less blur (0 = no blur)
    }

    RowLayout{

    
        spacing:15

        Second{
        
        }
    Timer {
        id : timer
        interval: 30
        running: false
        repeat: true

        onTriggered: {liveImage.source = "image://cv/live?" + Date.now();
        iTopLeft.source ="image://cv/TL?" + Date.now();iBottomLeft.source = "image://cv/BL?" + Date.now();iTopRight.source = "image://cv/TR?" + Date.now();
        iBottomRight.source = "image://cv/BR?" + Date.now();
        }
           //sureyı ekliyor
    }
    ColumnLayout{
                spacing: 20

    RowLayout{
        spacing: 20
        ColumnLayout{

            spacing: 10

            Image {

                id: iTopLeft
                source: "image://cv/live"
                Layout.preferredWidth: 320
                Layout.preferredHeight: 240
            }
            Image {
                id: iBottomLeft
                source: "image://cv/live"
                Layout.preferredWidth: 320
                Layout.preferredHeight: 240
            }
        }

    

        Image {

            id: liveImage               

            source: "image://cv/live"
            Layout.preferredWidth: 640
            Layout.preferredHeight: 480
            opacity: 0

            Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
            Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
            Behavior on opacity { NumberAnimation { duration: 300 } }

            MouseArea {
            anchors.centerIn:parent

            anchors.fill: parent
            hoverEnabled:true
            onClicked: (mouse) => {
                console.log("Clicked at:", mouse.x, mouse.y, "Button:", mouse.button)
                cv.getRoiQML(mouse.x,mouse.y)
            }
            onEntered: () => {
                console.log("Mouse entered")
                
            }
            onPositionChanged: (mouse) => {
                lineSeries.replace(1,Qt.point(mouse.x,mouse.y))
            }
        }

            onStatusChanged: {
                if (status === Image.Ready) {
                    opacity = 1
                }
            }
        }
        ColumnLayout{
            spacing: 10
            Image {
                id: iTopRight               

                //source: "image://cv/crop"
                Layout.preferredWidth: 320
                Layout.preferredHeight: 240

                Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
                Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
                Behavior on opacity { NumberAnimation { duration: 300 } }
                }


            Image {

                id: iBottomRight             

                //source: "image://cv/crop"
                Layout.preferredWidth: 320
                Layout.preferredHeight: 240

                Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
                Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
                Behavior on opacity { NumberAnimation { duration: 300 } }
            }
        }
    }
        
        

    GraphsView {
        id: line
        width: 300
        height: 300
        ValueAxis {
            id: valueAxisX
            min: 0
            max: 900
        }

        ValueAxis {
            id: valueAxisY
            min: 0
            max: 900
        }

        LineSeries {
            id: lineSeries
            XYPoint {
                x: 0
                y: 0
            }
            XYPoint {
                x: 3
                y: 21
            }
        }
        axisY: valueAxisY
        axisX: valueAxisX
    }

    }
}
}
    
