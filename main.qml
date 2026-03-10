import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
ApplicationWindow {
    visible: true
    title: "PySide6 QML Birles"
    width:1920
    height:1080
    Timer {
        id : timer
        interval: 30
        running: false
        repeat: true

        onTriggered: {liveImage.source = "image://cv/live?" + Date.now();
        iTopLeft.source ="image://cv/TL?" + Date.now();iBottomLeft.source = "image://cv/BL?" + Date.now();iTopRight.source = "image://cv/TR?" + Date.now();
        iBottomRight.source = "image://cv/BR?" + Date.now();
        }   //sureyı ekliyor
        

    }
    RowLayout{
        spacing: 20
        anchors.centerIn:parent
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

            onClicked: (mouse) => {
                console.log("Clicked at:", mouse.x, mouse.y, "Button:", mouse.button)
                cv.getRoiQML(mouse.x,mouse.y)
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
        
        

    RowLayout{        
        anchors.centerIn:parent
        y:500
        RangeSlider {
        id: rangeSlider
        width: 300
        second.value: 0.75
        first.value: 0.25
        second.onValueChanged: { cv.setBlurIntensity( 255*second.value) }
        }
    
    
    RangeSlider {
        id: rangeSlider1
        width: 150
        second.value: 0.75
        first.value: 0.25
        second.onValueChanged: { cv.setThreshMax( 255*second.value) }
    }
    
    
    RangeSlider {
        
        id: rangeSlider2
        width: 150
        second.value: 0.75
        first.value: 0.25

        second.onValueChanged: { cv.setCannyThresh( 255*second.value) }
        }


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
    
