import QtQuick
import QtQuick.Controls 
import QtQuick.Layouts
import QtQuick.Dialogs
import QtGraphs

ColumnLayout{
    id: columnLayout
    spacing:25
    width:150


    FileDialog{
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
        contentItem: Text{
                    color:"black"
                    text: "choosePath"
                    font.family:"MyFractionFont"
                        }
        id:fileDialogButton
        onClicked:fileDialog.open()
    }

       RangeSlider {
        id: rangeSlider
        width: 300
        second.value: 0.75
        first.value: 0.25
        second.onValueChanged: { cv.setBlurIntensity( 10*second.value) }
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

        second.onValueChanged: { cv.setCannyThresh( 50*second.value) }
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


