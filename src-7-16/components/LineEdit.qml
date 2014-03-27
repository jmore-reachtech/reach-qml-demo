import QtQuick 1.0

Rectangle {
    id: rec
    width: 100
    color: "White"
    border.color: "#505050"
    border.width: 2
    radius: 2
    property int padding: 2
    property alias text: editInput.text
    property alias fontPixelSize: editInput.font.pixelSize
    property alias maximumLength: editInput.maximumLength
    property alias validator: editInput.validator
    property alias cursorVisible: editInput.cursorVisible
    property alias font: editInput.font
    property alias maskedInput: editInput.inputMask
    property alias displayText: editInput.displayText
    property bool acceptableInput: editInput.acceptableInput

    height: fontPixelSize + padding*4

    signal buttonClick()
    onButtonClick: {
    }

    TextInput {
        id: editInput
        selectionColor: "green"
        width: parent.width - 8
        height: parent.height - 4
        anchors.centerIn: parent
        font.pixelSize: 12
        text: ""

        MouseArea {
            anchors.fill: parent
            onClicked: buttonClick()
            onEntered: {
                rec.border.color = "orange";
            }


        }
    }

}

