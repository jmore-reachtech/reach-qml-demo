import QtQuick 1.1
import "../components"
import "js/dataModel.js" as Db

Rectangle {
    width: 800
    height: 480
    id: root
    property string errorMessage: ""
    property int count

    signal message(string msg)

    Image{
        source: "../images/bg.png"
        anchors.fill: parent
    }

    Text{
        x: 188
        y: 42
        color: "#ffffff"
        text: "Add Coffee Recipe"
        font.pixelSize: 23
    }

    AlphaField {
        id: tbName
        x: 188
        y: 96
        width: 362
        height: 34
        keyboardBackGroundImage: "../capacitive_coffeedemo/images/keyboardbg.png"
        normalKeyIcon: "../capacitive_coffeedemo/images/key1_off.png"
        pressedKeyIcon: "../capacitive_coffeedemo/images/key1_on.png"
        fieldSpacing: 16
        inputText: ""
        keyTextColor: "#000000"
        keyTextBold: true
        keyTextFontSize: 14
        keyWidth: 45
        keyHeight: 55
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
        x: 559
        y: 111
        color: "Red"
        text: qsTr("*")
        font.pixelSize: 14
        z: 30
    }

    Text {
        id: txtVolume
        x: 187
        y: 149
        color: "#f7f6f6"
        text: qsTr("Volume")
        font.pixelSize: 18
    }

    NumericEdit {
        id: volume
        x: 188
        y: 172
        height: 40
        width: 130
        max: 16
        min: 2
        addDisplayText: true
        displayText: " OZ"
    }

    Text {
        id: txtTemp
        x: 185
        y: 233
        color: "#f7f6f6"
        text: qsTr("Temperature")
        font.pixelSize: 18
    }

    NumericEdit {
        id: temp
        x: 188
        y: 257
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
        x: 333
        y: 150
        color: "#f7f6f6"
        text: qsTr("Fill Pause")
        font.pixelSize: 18
    }

    NumericEdit {
        id: fillPause
        x: 333
        y: 172
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
        x: 333
        y: 233
        color: "#f7f6f6"
        text: qsTr("Extraction Time")
        font.pixelSize: 18
    }

    NumericEdit {
        id: extractionTime
        x: 333
        y: 257
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
        x: 497
        y: 149
        color: "#f7f6f6"
        text: qsTr("Turbulence On")
        font.pixelSize: 18
    }

    NumericEdit {
        id: turbulenceOn
        x: 497
        y: 172
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
        x: 497
        y: 233
        color: "#f7f6f6"
        text: qsTr("Turbulence Off")
        font.pixelSize: 18
    }

    NumericEdit {
        id: turbulenceOff
        x: 497
        y: 257
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
        x: 322
        y: 322
        width: 76
        height: 64
        text: ""
        imageUp: "../capacitive_coffeedemo/images/btnSave.png"
        imageDown: "../capacitive_coffeedemo/images/btnSaveOff.png"
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
                    Db.currentIndex = res;
                    root.message("resistive_coffeedemo/mainview.qml");
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
        x: 392
        y: 322
        width: 76
        height: 64
        text: ""
        imageUp: "../capacitive_coffeedemo/images/btnCancel.png"
        imageDown: "../capacitive_coffeedemo/images/btnCancelOff.png"
        onButtonClick: {
            root.message("resistive_coffeedemo/mainview.qml")
        }
    }


    Rectangle{
        id: opaqueWindow
        width: parent.width
        height: parent.height
        x:0
        y:0
        visible: false
        opacity: 1.0

        Image{
            source: "../images/bg.png"
            anchors.fill: parent
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
            imageUp: "../capacitive_coffeedemo/images/btnCancel.png"
            imageDown: "../capacitive_coffeedemo/images/btnCancelOff.png"
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



