import QtQuick 1.1

Rectangle {
    property alias font: input.font
    property string text: ""
    property alias maximumLength: input.maximumLength
    property alias validator: input.validator
    property alias cursorVisible: input.cursorVisible;
    signal textChanged(string text)
    signal buttonClick()
    onButtonClick: {
    }

    id: lineEdit
    height: input.height + 8
    color: "White"
    radius: 2
    border.color: "gray"
    border.width: 2

    TextInput {
        id: input
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        color: "black"

        text: lineEdit.text
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            input.focus = true;
            lineEdit.border.color = "orange";
            onClicked: buttonClick();
        }
        onPressed: {
            input.focus = true;
            lineEdit.border.color = "orange";
            onClicked: buttonClick();
        }
    }



    Keys.onReturnPressed: {
        lineEdit.textChanged(input.text)
        lineEdit.focus = true
    }
    Keys.onEnterPressed: {
        lineEdit.textChanged(input.text)
        lineEdit.focus = true
    }
    Keys.onEscapePressed: {
        input.text = text
        lineEdit.focus = true
    }
}
