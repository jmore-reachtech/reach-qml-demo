import QtQuick 1.1

Rectangle {
    id: button
    width: 120
    height: 23
    property alias text: innerText.text
    property alias imageChecked: imageChecked.source
    property alias imageUnchecked: imageUnchecked.source
    property bool checked: false
    property string value: ""
    property alias font: innerText.font
    property alias textColor: innerText.color
    signal clicked
    color: "transparent"


    BorderImage{
        id: imageChecked
        anchors.left: button.left
        source: "../images/radio_checked.svg"
        visible: button.checked
    }

    BorderImage{
        id: imageUnchecked
        anchors.left: button.left
        source: "../images/radio_unchecked.svg"
        visible: !button.checked
    }

    Text{
        id: innerText
        anchors.left: imageChecked.right
        anchors.leftMargin: 4
        enabled: button.enabled
        color: "White"
        text: "Radio Button"
        font.pixelSize: 14
        verticalAlignment: Text.AlignVCenter
        height: button.height
    }


    MouseArea{
        anchors.fill: button
        onClicked: {
            checked = !checked;
            button.clicked();
        }
    }



}
