import QtQuick 1.1

Rectangle {
    id: rec
    width: parent.width
    height: 24
    color: "White"
    border.color: "#505050"
    border.width: 2
    radius: 2
    property alias text: editInput.text
    property alias fontPixelSize: editInput.font.pointSize
    property alias fontFamily: editInput.font.family
    property alias maximumLength: editInput.maximumLength
    property alias validator: editInput.validator
    property alias cursorVisible: editInput.cursorVisible;

    signal buttonClick()
    onButtonClick: {
    }

TextInput {
    id: editInput
    width: parent.width - 2
    selectionColor: "green"
    anchors.centerIn: parent
        MouseArea {
            anchors.fill: parent
            onClicked: buttonClick()
            onEntered: {
                rec.border.color = "orange";
            }


        }
     }
}
