import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
ApplicationWindow {
    visible: true
    title: "PySide6 QML Birles"
    width:900
    height:600
    Timer {
        id : timer
        interval: 30
        running: false
        repeat: true

        onTriggered: liveImage.source = "image://cv/live?" + Date.now()  //sureyı ekliyor
    }
    ColumnLayout{
        spacing:2
        anchors.centerIn:parent
    
        Image {

            id: liveImage               
        
            source: "image://cv/live"
            Layout.preferredWidth: 640
            Layout.preferredHeight: 480
            fillMode: Image.PreserveAspectFit
            opacity: 0

            Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
            Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
            Behavior on opacity { NumberAnimation { duration: 300 } }

            MouseArea {

            anchors.fill: parent
            onClicked: (mouse) => {
                console.log("Clicked at:", mouse.x, mouse.y, "Button:", mouse.button)
                parent.color = "lightgreen"
            }
            onEntered: () => {
                console.log("Mouse entered")
            }
        }

            onStatusChanged: {
                if (status === Image.Ready) {
                    opacity = 1
                }
            }
        }

        RowLayout{        
            anchors.centerIn:parent
            Button {

                id : startButton
                contentItem: Text{
                        color:"black"
                        text: "start video"
                        font.family:"MyFractionFont"
                            }
                onClicked:{
                    backend.startVideo();
                    timer.start();
                    }
            }
            

            Button {

                id : previousButon

                contentItem: Text{
                        color:"black"
                        text: "previous process"
                        font.family:"MyFractionFont"
                            }
                onClicked: {

                
                    backend.setIndex(-1)
                    }
                }

            Button {
                id : nextButton

                contentItem: Text{
                        color:"black"
                        text: "nextprocess"
                        font.family:"MyFractionFont"
                            }
                onClicked: {
                    backend.setIndex(1)
                }
            }
        }

    }
    
}