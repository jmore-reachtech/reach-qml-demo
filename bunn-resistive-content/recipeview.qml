import QtQuick 1.1

import "../content/components"
import "../content/js/dataModel.js" as Db
import "../content/js/ops.js" as Ops


Rectangle {
    width: 480
    height: 272
    id: root
    color: "#2D2D2D"
    z: 200
    property string rotateLeft: "\u2939"
    property string rotateRight: "\u2935"
    property string leftArrow: "\u2190"
    property string upperArrow: "\u2191"
    property string division : "\u00f7"
    property string multiplication : "\u00d7"
    property string squareRoot : "\u221a"
    property string plusminus : "\u00b1"
    property string editObject: "textEdit"
    property string errorMessage: "";
    property bool keyBoardLoaded: false

    signal message(string msg)

    gradient: Gradient {
        GradientStop {position: 0.0; color: "#2D2D2D"}
        GradientStop {position: 1.0; color: "#666666"}
    }

    Text {
        Component.onCompleted: console.log("Name")
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
            opaqueWindow.visible = true;
            opaqueWindow.opacity = 1.0;
            Ops._editObject = tbName;

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
        y: 34
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
        x: 159
        y: 36
        color: "#f7f6f6"
        text: qsTr("Fill Pause")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: fillPause
        x: 157
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
        x: 157
        y: 95
        color: "#f7f6f6"
        text: qsTr("Extraction Time")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: extractionTime
        x: 157
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
        x: 322
        y: 32
        color: "#f7f6f6"
        text: qsTr("Turbulence On")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: turbulenceOn
        x: 322
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
        x: 319
        y: 95
        color: "#f7f6f6"
        text: qsTr("Turbulence Off")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: turbulenceOff
        x: 319
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
        x: 318
        y: 151
        color: "#f7f6f6"
        text: qsTr("Turbulence Power")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: turbulencePower
        x: 320
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
        x: 157
        y: 151
        color: "#f7f6f6"
        text: qsTr("Press Out Power")
        font.family: "MV Boli"
        font.pointSize: 13
    }

    NumericEdit {
        id: pressOutPower
        x: 159
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
        x: 303
        y: 212
        width: 66
        height: 56
        imageOn: "images/btnSave.png"
        imageOff: "images/btnSaveOff.png"
        onButtonClick: {
            txtMsg.text = "*";
            if (tbName.text.trim().length > 0)
            {
                var recipe = Db.dataList.get(Db.currentIndex);
                recipe.recipeName = tbName.text;
                recipe.volume = volume.value;
                recipe.temp = temp.value;
                recipe.preInfusion = preInfusion.value;
                recipe.preWet = preWet.value;
                recipe.fillPause = fillPause.value;
                recipe.extractionTime = extractionTime.value;
                recipe.turbulenceOn = turbulenceOn.value;
                recipe.turbulenceOff = turbulenceOff.value;
                recipe.turbulencePower = turbulencePower.value;
                recipe.pressOutPower = pressOutPower.value;
                var res = Db.updateRecipe(recipe);
                if (res > 0)
                {
                    root.message("visible");
                }
                else
                {
                    errorMessage = res;
                    opaqueWindow.visible = true;
                    errorWindow.visible = true;
                }


            }
            else
            {
                txtMsg.text = "Required";
            }
        }
    }

    ImageButton {
        id: btnDelete
        x: 360
        y: 212
        width: 66
        height: 56
        imageOn: "images/btnDelete.png"
        imageOff: "images/btnDeleteOff.png"
        onButtonClick: {
            opaqueWindow.visible = true;
            opaqueWindow.z = 32;
            confirmWindow.visible = true;
        }
    }

    ImageButton {
        id: btnCancel
        x: 417
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
        opacity: 0.8

        gradient: Gradient {
            GradientStop {position: 0.0; color: "#2D2D2D"}
            GradientStop {position: 1.0; color: "#666666"}
        }
        z: 10

    }

    Rectangle{
        id: confirmWindow
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
            id: txtConfirm
            width: parent.width
            text: "Are you sure you wish\n to delete this recipe?"
            font.pointSize: 17
            font.family: "MV Boli"
            horizontalAlignment: Text.AlignHCenter
            color: "White"
            x: 0
            y: 42

        }

        ImageButton {
            id: btnConfirmYes
            x: 70
            y: 129
            width: 66
            height: 56
            imageOn: "images/btnYes.png"
            imageOff: "images/btnYesOff.png"
            onButtonClick: {
                //First delete from the database
                var res = Db.deleteRecipe(Db.dataList.get(Db.currentIndex).recipeId);
                if (res > 0)
                {
                    Db.dataList.remove(Db.currentIndex);
                    Db.currentIndex = 0;
                    root.message("update");
                }
            }
        }

        ImageButton {
            id: btnConfirmNo
            x: 155
            y: 129
            width: 66
            height: 56
            imageOn: "images/btnCancel.png"
            imageOff: "images/btnCancelOff.png"
            onButtonClick: {
                opaqueWindow.z = 10;
                opaqueWindow.visible = false;
                confirmWindow.visible = false;
            }
        }

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
       keyHeight: 46
       keyWidth: 40
       onKeyEvent: {
           Ops.doTextOperation(event);
        }
    }

    Component.onCompleted: {
        //Initialize components
        tbName.text = Db.dataList.get(Db.currentIndex).recipeName;
        volume.value = Db.dataList.get(Db.currentIndex).volume;
        temp.value = Db.dataList.get(Db.currentIndex).temp;
        preInfusion.value = Db.dataList.get(Db.currentIndex).preInfusion;
        preWet.value = Db.dataList.get(Db.currentIndex).preWet;
        fillPause.value = Db.dataList.get(Db.currentIndex).fillPause;
        extractionTime.value = Db.dataList.get(Db.currentIndex).extractionTime;
        turbulenceOn.value = Db.dataList.get(Db.currentIndex).turbulenceOn;
        turbulenceOff.value = Db.dataList.get(Db.currentIndex).turbulenceOff;
        turbulencePower.value = Db.dataList.get(Db.currentIndex).turbulencePower;
        pressOutPower.value = Db.dataList.get(Db.currentIndex).pressOutPower;

        //Position the delete and cancel buttons
        if (Db.dataList.get(Db.currentIndex).machineRecipe == 1)
        {
            //hide delete button
            btnDelete.visible = false;
            btnCancel.x = 370;
            btnSave.x = 313;
        }

    }
}



