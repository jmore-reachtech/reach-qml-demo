import QtQuick 1.1

import "../components"
import "js/dataModel.js" as Db


Rectangle {
    width: 480
    height: 272
    id: root
    color: "#2D2D2D"
    property string errorMessage: ""
    property int count

    signal message(string msg)

    gradient: Gradient {
        GradientStop {position: 0.0; color: "#666666"}
        GradientStop {position: 1.0; color: "#EEEEEE"}
    }

    AlphaField {
        id: tbName
        x: 13
        y: 20
        width: 362
        height: 34
        keyboardBackGroundImage: "images/keyboardbg.png"
        normalKeyIcon: "images/key1_off.png"
        pressedKeyIcon: "images/key1_on.png"
        fieldSpacing: 16
        inputText: ""
        keyTextColor: "#000000"
        keyTextBold: false
        keyHeight: 44
        keyWidth: 42
        keyTextFontSize: 14
        inputColor: "#ffffff"
        labelColor: "#f7f6f6"
        inputFontPixelSize: 18
        keyboardAnimationSpeed: 100
        inputFontFamily: "Arial"
        labelFontFamily: "Arial"
        labelFontPixelSize: 18
        labelText: "Name"
        z: 30
    }

    Text {
        id: txtMsg
        x: 390
        y: 28
        color: "Red"
        text: qsTr("*")
        font.pixelSize: 14
        z: 30
    }

    Text {
        id: txtVolume
        x: 12
        y: 66
        color: "#f7f6f6"
        text: qsTr("Volume")
        font.pixelSize: 18
    }

    NumericSelector {
        id: volume
        x: 13
        y: 89
        height: 40
        width: 130
        max: 16
        min: 2
        displayText: " OZ"
    }

    Text {
        id: txtTemp
        x: 10
        y: 137
        color: "#f7f6f6"
        text: qsTr("Temperature")
        font.pixelSize: 18
    }

    NumericSelector {
        id: temp
        x: 13
        y: 161
        height: 40
        width: 130
        max: 208
        min: 165
        increment: 1
        displayText: qsTr("<sup>o</sup>F")
    }


    Text {
        id: txtFillPause
        x: 158
        y: 67
        color: "#f7f6f6"
        text: qsTr("Fill Pause")
        font.pixelSize: 18
    }

    NumericSelector {
        id: fillPause
        x: 158
        y: 89
        height: 40
        width: 150
        max: 25.0
        min: 1.0
        precision: 1
        increment: 0.1
        displayText: " Secs"
    }

    Text {
        id: txtExtractionTime
        x: 158
        y: 137
        color: "#f7f6f6"
        text: qsTr("Extraction Time")
        font.pixelSize: 18
    }

    NumericSelector {
        id: extractionTime
        x: 158
        y: 161
        height: 40
        width: 150
        max: 180
        min: 20
        precision: 0
        increment: 1
        displayText: " Secs"
    }

    Text {
        id: txtTurbulenceOn
        x: 322
        y: 66
        color: "#f7f6f6"
        text: qsTr("Turbulence On")
        font.pixelSize: 18
    }

    NumericSelector {
        id: turbulenceOn
        x: 322
        y: 89
        height: 40
        width: 140
        max: 45
        min: 1
        precision: 0
        increment: 1
        displayText: " Secs"
    }

    Text {
        id: txtTurbulenceOff
        x: 322
        y: 137
        color: "#f7f6f6"
        text: qsTr("Turbulence Off")
        font.pixelSize: 18
    }

    NumericSelector {
        id: turbulenceOff
        x: 322
        y: 161
        height: 40
        width: 140
        max: 40
        min: 1
        precision: 0
        increment: 1
        displayText: " Secs"
    }

    ImageButton {
        id: btnSave
        x: 166
        y: 206
        width: 76
        height: 64
        text: ""
        imageUp: "images/btnSave.png"
        imageDown: "images/btnSaveOff.png"
        onButtonClick: {
            txtMsg.text = "*";
            if (tbName.inputText.trim().length > 0)
            {
                //Insert recipe to the database and get the ID
                var res = Db.insertRecipe(0, tbName.inputText, volume.value, 0, 0, fillPause.value, extractionTime.value,
                                turbulenceOn.value, turbulenceOff.value, 0,
                                0, 60, temp.value);
                if (res > 0)
                {           
                    Db.currentIndex = root.count - 1;
                    root.message("capacitive_coffeedemo/mainview.qml");
                }
                else
                {
                    //Show error here
                    tbName.visible = false;           
                    txtMsg.visible = false;
                    errorMessage = res;
                    errorWindow.visible = true;
                    opaqueWindow.visible = true;
                }
            }
            else
            {
                txtMsg.text = "Required";
            }

        }
    }

    ImageButton {
        id: btnCancel
        x: 236
        y: 206
        width: 76
        height: 64
        text: ""
        imageUp: "images/btnCancel.png"
        imageDown: "images/btnCancelOff.png"
        onButtonClick: {
            root.message("capacitive_coffeedemo/mainview.qml")
        }
    }


    Rectangle{
        id: opaqueWindow
        width: parent.width
        height: parent.height
        x:0
        y:0
        visible: false
        color: "#2D2D2D"
        opacity: 1.0

        gradient: Gradient {
            GradientStop {position: 0.0; color: "#2D2D2D"}
            GradientStop {position: 1.0; color: "#666666"}
        }
    }


    Rectangle{
        id: errorWindow
        width: 300
        height: 240
        border.color: "#000000"
        border.width: 4
        radius: 8
        smooth: true
        visible: false;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        color: "#2D2D2D"

        gradient: Gradient {
            GradientStop {position: 0.0; color: "#2D2D2D"}
            GradientStop {position: 1.0; color: "#666666"}
        }
        Text{
            id: txtError
            width: parent.width
            height: 95
            text: "An error occurred: \n" + errorMessage
            wrapMode: Text.WordWrap
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            color: "White"
            x: 0
            y: 18

        }


        ImageButton {
            id: btnErrorCancel
            x: 117
            y: 132
            width: 76
            height: 64
            text: ""
            imageUp: "images/btnCancel.png"
            imageDown: "images/btnCancelOff.png"
            onButtonClick: {
                tbName.visible = true;
                txtMsg.visible = true;
                errorWindow.visible = false;
                opaqueWindow.visible = false;
            }
        }

    }

    Component.onCompleted: {
        volume.value = 8;
        temp.value = 200;
        fillPause.value = 5;
        extractionTime.value = 45;
        turbulenceOn.value = 5;
        turbulenceOff.value = 10;
        root.count = Db.getRecipeCount();
    }

}



