import QtQuick 1.1

import "components"
import "js/dataModel.js" as Db
import "js/ops.js" as Ops


Rectangle {
    width: 480
    height: 272
    id: root
    objectName: "root"
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

    property alias m_Name: tbName.text
    property alias m_Volume: volume.value
    property alias m_FillPause: fillPause.value
    property alias m_ExtractionTime: extractionTime.value
    property alias m_TurbulenceOn: turbulenceOn.value
    property alias m_TurbulenceOff: turbulenceOff.value
    property alias m_Temp: temp.value

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
        x: 128
        y: 206
        width: 76
        height: 64
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
                recipe.fillPause = fillPause.value;
                recipe.extractionTime = extractionTime.value;
                recipe.turbulenceOn = turbulenceOn.value;
                recipe.turbulenceOff = turbulenceOff.value;
                var res = Db.updateRecipe(recipe);
                if (res > 0)
                {
                    root.message("coffeeview.qml");
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
        x: 200
        y: 206
        width: 76
        height: 64
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
        x: 270
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
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            color: "White"
            x: 0
            y: 42

        }

        ImageButton {
            id: btnConfirmYes
            x: 70
            y: 129
            width: 76
            height: 64
            imageOn: "images/btnYes.png"
            imageOff: "images/btnYesOff.png"
            onButtonClick: {
                //First delete from the database
                var res = Db.deleteRecipe(Db.dataList.get(Db.currentIndex).recipeId);
                if (res > 0)
                {
                    Db.dataList.remove(Db.currentIndex);
                    Db.currentIndex = 0;
                    root.message("coffeeview.qml");
                }
            }
        }

        ImageButton {
            id: btnConfirmNo
            x: 155
            y: 129
            width: 76

            height: 64
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
        fillPause.value = Db.dataList.get(Db.currentIndex).fillPause;
        extractionTime.value = Db.dataList.get(Db.currentIndex).extractionTime;
        turbulenceOn.value = Db.dataList.get(Db.currentIndex).turbulenceOn;
        turbulenceOff.value = Db.dataList.get(Db.currentIndex).turbulenceOff;

        //Position the delete and cancel buttons
        if (Db.dataList.get(Db.currentIndex).machineRecipe == 1)
        {
            //hide delete button
            btnDelete.visible = false;
            btnCancel.x = 236;
            btnSave.x = 166;
        }

    }
}



