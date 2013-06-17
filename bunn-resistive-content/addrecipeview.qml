import QtQuick 1.1

import "../content/components"
import "../content/js/dataModel.js" as Db
import "../content/js/ops.js" as Ops


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
        x: 22
        y: 9
        color: "#f7f6f6"
        text: qsTr("Name")
        font.family: "MV Boli"
        font.pointSize: 13
        z: 30
    }

    LineEdit {
        id: tbName
        x: 74
        y: 5
        width: 244
        font.pixelSize: 13
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
        x: 326
        y: 9
        color: "Red"
        text: qsTr("*")
        font.family: "MV Boli"
        font.pointSize: 13
        z: 30
    }

    Text {
        id: txtVolume
        x: 21
        y: 35
        color: "#f7f6f6"
        text: qsTr("Volume")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: volume
        x: 22
        y: 58
        height: 30
        width: 100
        max: 16
        min: 2
        addDisplayText: true
        displayText: " oz"
    }

    Text {
        id: txtTemp
        x: 19
        y: 94
        color: "#f7f6f6"
        text: qsTr("Temperature")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: temp
        x: 22
        y: 118
        height: 30
        width: 106
        max: 208
        min: 165
        increment: 1
        addDisplayText: true
        displayText: qsTr("<sup>o</sup>F")
    }

    Text {
        id: txtPreInfusion
        x: 22
        y: 151
        color: "#f7f6f6"
        text: qsTr("Pre-Infusion")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: preInfusion
        x: 22
        y: 174
        height: 30
        width: 100
        max: 100
        min: 0
        increment: 10
        addDisplayText: true
        displayText: "%"
    }

    Text {
        id: txtPreWet
        x: 22
        y: 208
        color: "#f7f6f6"
        text: qsTr("Pre-Wet")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: preWet
        x: 21
        y: 231
        height: 30
        width: 132
        max: 1.0
        min: 0.0
        precision: 1
        increment: 0.1
        addDisplayText: true
        displayText: " Secs"
    }

    Text {
        id: txtFillPause
        x: 163
        y: 36
        color: "#f7f6f6"
        text: qsTr("Fill Pause")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: fillPause
        x: 161
        y: 59
        height: 30
        width: 139
        max: 25.0
        min: 1.0
        precision: 1
        increment: 0.1
        addDisplayText: true
        displayText: " Secs"
    }

    Text {
        id: txtExtractionTime
        x: 161
        y: 95
        color: "#f7f6f6"
        text: qsTr("Extraction Time")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: extractionTime
        x: 161
        y: 118
        height: 30
        width: 133
        max: 180
        min: 20
        precision: 0
        increment: 1
        addDisplayText: true
        displayText: " Secs"
    }

    Text {
        id: txtTurbulenceOn
        x: 326
        y: 33
        color: "#f7f6f6"
        text: qsTr("Turbulence On")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: turbulenceOn
        x: 326
        y: 58
        height: 30
        width: 133
        max: 45
        min: 1
        precision: 0
        increment: 1
        addDisplayText: true
        displayText: " Secs"
    }

    Text {
        id: txtTurbulenceOff
        x: 323
        y: 95
        color: "#f7f6f6"
        text: qsTr("Turbulence Off")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: turbulenceOff
        x: 323
        y: 118
        height: 30
        width: 133
        max: 40
        min: 1
        precision: 0
        increment: 1
        addDisplayText: true
        displayText: " Secs"
    }

    Text {
        id: txtTurbulencePower
        x: 322
        y: 151
        color: "#f7f6f6"
        text: qsTr("Turbulence Power")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: turbulencePower
        x: 324
        y: 174
        height: 30
        width: 90
        max: 7
        min: 1
        precision: 0
        increment: 1
        addDisplayText: false
        displayText: ""
    }

    Text {
        id: txtpressOutPower
        x: 161
        y: 151
        color: "#f7f6f6"
        text: qsTr("Press Out Power")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: pressOutPower
        x: 163
        y: 174
        height: 30
        width: 90
        max: 7
        min: 1
        precision: 0
        increment: 1
        addDisplayText: false
        displayText: ""
    }

    ImageButton {
        id: btnSave
        x: 317
        y: 212
        width: 66
        height: 56
        imageOn: "images/btnSave.png"
        imageOff: "images/btnSaveOff.png"
        onButtonClick: {
            txtMsg.text = "*";
            if (tbName.text.trim().length > 0)
            {
                //Insert recipe to the database and get the ID
                var res = Db.insertRecipe(0, tbName.text, volume.value, preWet.value, preInfusion.value, fillPause.value, extractionTime.value,
                                turbulenceOn.value, turbulenceOff.value, turbulencePower.value,
                                pressOutPower.value, 60, temp.value);
                if (res > 0)
                {
                    Db.dataList.append({recipeId: res, machineRecipe: 0, recipeName: tbName.text, volume: volume.value, preWet: preWet.value,
                        preInfusion: preInfusion.value, fillPause: fillPause.value, extractionTime: extractionTime.value,
                        turbulenceOn: turbulenceOn.value, turbulenceOff: turbulenceOff.value, turbulencePower: turbulencePower.value,
                        pressOutPower: pressOutPower.value, pressOutTime: 60, temp: temp.value});

                    Db.currentIndex = Db.dataList.count - 1;
                    root.message("update");
                }
                else
                {
                    //Show error here
                    console.debug(res);
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
        x: 385
        y: 212
        width: 66
        height: 56
        imageOn: "images/btnCancel.png"
        imageOff: "images/btnCancelOff.png"
        onButtonClick: {
            root.message("visible")
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
        z: 10
    }


    Rectangle{
        id: errorWindow
        width: 300
        height: 200
        border.color: "#000000"
        border.width: 4
        radius: 8
        smooth: true
        visible: false;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 33

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
            font.pointSize: 13
            font.family: "MV Boli"
            horizontalAlignment: Text.AlignHCenter
            color: "White"
            x: 0
            y: 18

        }


        ImageButton {
            id: btnErrorCancel
            x: 117
            y: 132
            width: 66
            height: 56
            imageOn: "images/btnCancel.png"
            imageOff: "images/btnCancelOff.png"
            onButtonClick: {
                errorWindow.z = 10;
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
        preInfusion.value = 10;
        preWet.value = 0.0;
        fillPause.value = 5;
        extractionTime.value = 45;
        turbulenceOn.value = 5;
        turbulenceOff.value = 10;
        turbulencePower.value = 4;
        pressOutPower.value = 7;
    }

}



