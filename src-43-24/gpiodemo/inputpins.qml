import QtQuick 1.1
import "../components"

Rectangle {
    id: root
    objectName: "root"
    width: 480
    height: 272

    gradient: Gradient {
        GradientStop {
            position: 0.16
            color: "#afacac"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }

    signal message(string msg)

	
	

	Text {
        id: txtTitle
        x: 0
        y: 8
        width: 491
        height: 25
        text: qsTr("GPIO Plugin Demo")
        anchors.horizontalCenterOffset: -5
        horizontalAlignment: Text.AlignHCenter
        font.bold: false
        font.pixelSize: 21
        anchors.horizontalCenter: parent.horizontalCenter
    }
	
    NumericSelector {
        id: writeValue
        x: 186
        y: 68
        height: 33
        width: 109
        max: 32
        min: 0
        displayText: ""
    }

	GPIOPinInput{
        id: pin2
        pin: 2
        pollPin: false
    }

    GPIOPinInput{
        id: pin3
        pin: 3
        pollPin: false
    }
	
    GPIOPinsOutput{
        id: pinsOutput
    }

    ImageButton {
        id: quitButton
        x: 192
        y: 112
        width: 98
        height: 27
        text: "Submit"
        font.bold: true
        imageDown: "../images/internal_button_dn.bmp"
        imageUp: "../images/internal_button_up.bmp"
        onButtonClick: pinsOutput.writeToPins(writeValue.value);
    }

     Text {
         id: text1
         x: 0
         y: 163
         width: 480
         height: 20
         color: "#ffffff"
         text: qsTr("Input Register")
         horizontalAlignment: Text.AlignHCenter
         font.bold: true
         font.family: "DejaVu Sans"
         font.pixelSize: 15
     }

     PanelReadOut {
         id: panel
         x: 156
         y: 184
         width: 174
         height: 62
         text: ""
         font.pixelSize: 22
         textColor: "#50dd0e"
         imagePanel: "../images/bezel.bmp"
         font.bold: false
         font.family: "DejaVu Sans"
     }

        GPIOPinsInput{
        id: pinsInput

        onStateChanged:{
            if (state < 16)
                panel.text = "0x0" + pinsInput.getHexState();
            else
                panel.text = "0x" + pinsInput.getHexState();
        }
    }
	
        ImageButton{
            id:prevButton
            x: 21
            y: 199
            width: 48
            height: 48
            text: ""

            imageDown: "images/prev_down.png"
            imageUp: "images/prev_up.png"


            onButtonClick: {
                root.message("gpiodemo/mainview.qml");
            }
        }

        Text {
            id: text2
            x: 0
            y: 44
            width: 480
            height: 18
            color: "#ffffff"
            text: qsTr("Write To Register")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 15
            font.bold: true
            font.family: "DejaVu Sans"
        }

        Rectangle {
            id: rectangle1
            x: 0
            y: 145
            width: 480
            height: 5
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#ffffff"
                }

                GradientStop {
                    position: 0.27
                    color: "#000000"
                }

                GradientStop {
                    position: 0.85
                    color: "#ffffff"
                }
            }
        }

}	
