import QtQuick 1.1

import "components"
import "js/dataModel.js" as Db
import "js/ops.js" as Ops


Rectangle {
    width: 480
    height: 272
    id: root
    color: "#2D2D2D"
    property string rotateLeft: "\u2939"
    property string rotateRight: "\u2935"
    property string leftArrow: "\u2190"
    property string upperArrow: "\u2191"
    property string division : "\u00f7"
    property string multiplication : "\u00d7"
    property string squareRoot : "\u221a"
    property string plusminus : "\u00b1"
    property string editObject: "textEdit"
    property string errorMessage: ""
    property bool keyBoardLoaded: false

    signal message(string msg)

    gradient: Gradient {
        GradientStop {position: 0.0; color: "#2D2D2D"}
        GradientStop {position: 1.0; color: "#666666"}
    }

    Text {
        id: txtName
        x: 13
        y: 24
        color: "#f7f6f6"
        text: qsTr("Name")
        font.pixelSize: 18
        z: 30
    }

    LineEdit {
        id: tbName
        x: 80
        y: 22
        width: 300
        font.pixelSize: 20
        maximumLength: 30
        z:31

        onButtonClick: {
            Ops._editObject = tbName;
            opaqueWindow.visible = true;

            if (!keyBoardLoaded)
            {
                vk.buildKeyboard();
                keyBoardLoaded = true;
            }

            vk.state = "active";
            tbName.cursorVisible = true;
            tbName.border.color = "Orange";
        }
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

    NumericEdit {
        id: volume
        x: 13
        y: 89
        height: 40
        width: 130
        max: 16
        min: 2
        addDisplayText: true
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

    NumericEdit {
        id: temp
        x: 13
        y: 161
        height: 40
        width: 130
        max: 208
        min: 165
        increment: 1
        addDisplayText: true
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

    NumericEdit {
        id: fillPause
        x: 158
        y: 89
        height: 40
        width: 150
        max: 25.0
        min: 1.0
        precision: 1
        increment: 0.1
        addDisplayText: true
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

    NumericEdit {
        id: extractionTime
        x: 158
        y: 161
        height: 40
        width: 150
        max: 180
        min: 20
        precision: 0
        increment: 1
        addDisplayText: true
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

    NumericEdit {
        id: turbulenceOn
        x: 322
        y: 89
        height: 40
        width: 140
        max: 45
        min: 1
        precision: 0
        increment: 1
        addDisplayText: true
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

    NumericEdit {
        id: turbulenceOff
        x: 322
        y: 161
        height: 40
        width: 140
        max: 40
        min: 1
        precision: 0
        increment: 1
        addDisplayText: true
        displayText: " Secs"
    }

    ImageButton {
        id: btnSave
        x: 166
        y: 206
        width: 76
        height: 64
        imageOn: "images/btnSave.png"
        imageOff: "images/btnSaveOff.png"
        onButtonClick: {
            txtMsg.text = "*";
            if (tbName.text.trim().length > 0)
            {
                //Insert recipe to the database and get the ID
                var res = Db.insertRecipe(0, tbName.text, volume.value, 0, 0, fillPause.value, extractionTime.value,
                                turbulenceOn.value, turbulenceOff.value, 0,
                                0, 60, temp.value);
                if (res > 0)
                {
                    Db.dataList.append({recipeId: res, machineRecipe: 0, recipeName: tbName.text, volume: volume.value, preWet: 0,
                        preInfusion: 0, fillPause: fillPause.value, extractionTime: extractionTime.value,
                        turbulenceOn: turbulenceOn.value, turbulenceOff: turbulenceOff.value, turbulencePower: 0,
                        pressOutPower: 0, pressOutTime: 60, temp: temp.value});

                    Db.currentIndex = Db.dataList.count - 1;
                    root.message("coffeeview.qml");
                }
                else
                {
                    //Show error here
                    console.debug(res);
                    tbName.visible = false;
                    txtName.visible = false;
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
        imageOn: "images/btnCancel.png"
        imageOff: "images/btnCancelOff.png"
        onButtonClick: {
            root.message("coffeeview.qml")
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
            imageOn: "images/btnCancel.png"
            imageOff: "images/btnCancelOff.png"
            onButtonClick: {
                tbName.visible = true;
                txtName.visible = true;
                txtMsg.visible = true;
                errorWindow.visible = false;
                opaqueWindow.visible = false;
            }
        }

    }


    // Virtual keyboard pops up when a user enters the textEdit control
    VirtualKeyboard {
       id: vk
       z: 30
       keyHeight: 44
       keyWidth: 38
       onKeyEvent: {
           Ops.doTextOperation(event);
        }
    }

    Component.onCompleted: {
        volume.value = 8;
        temp.value = 200;
        fillPause.value = 5;
        extractionTime.value = 45;
        turbulenceOn.value = 5;
        turbulenceOff.value = 10;
    }

}



