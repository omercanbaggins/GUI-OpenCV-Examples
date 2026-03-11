import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Dialogs
import QtGraphs

ApplicationWindow {
    visible: true
    title: "PySide6 QML Birles"
    width:1920
    height:1080
    FileDialog {
            id: fileDialog
            visible: false
            onAccepted: {
            console.log("User selected:", selectedFile);
            backend.setPath(selectedFile)
    }

    onRejected: {
        console.log("User canceled")
    }
        }
    Button{
        id:fileDialogButton
        onClicked:fileDialog.open()
    }
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
                if(timer.running==false){
                    backend.startVideo();
                    startButton.Text.text = "stop video"
                    timer.start();
                    timer.running=true

                }
                else{
                    backend.timer.stop()
                    backend.startVideo();
                    startButton.Text = "start video"
                    timer.stop();
                    timer.running=false

                }
            
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
    GraphsView {
        id: line
        x: 872
        y: 438
        width: 350
        height: 350
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
    
