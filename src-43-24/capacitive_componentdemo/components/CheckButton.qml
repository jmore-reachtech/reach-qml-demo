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
    property int spacing: 6
    signal clicked
    color: "transparent"


    BorderImage{
        id: imageChecked
        anchors.left: button.left
        source: "../images/radiobutton_click.png"
        visible: button.checked
        height: button.height
        width: button.width
        smooth: true
    }

    BorderImage{
        id: imageUnchecked
        anchors.left: button.left
        source: "../images/radiobutton.png"
        visible: !button.checked
        height: button.height
        width: button.width
        smooth: true
    }

    Text{
        id: innerText
        anchors.left: imageChecked.right
        anchors.leftMargin: button.spacing
        enabled: button.enabled
        color: "White"
        text: "Radio Button"
        font.pixelSize: 14
        verticalAlignment: Text.AlignVCenter
    }


    MouseArea{
        anchors.fill: button
        onClicked: {
            checked = !checked;
            button.clicked();
        }
    }



}
