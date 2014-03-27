import QtQuick 1.1

Rectangle {
    id: button
    property alias text: innerText.text
    property alias imageChecked: imgChecked.source
    property alias imageUnchecked: imgUnchecked.source
    property int imageHeight: 32
    property int imageWidth: 32
    property bool checked: false
    property string value: ""
    property alias font: innerText.font
    property alias textColor: innerText.color
    property int spacing: 6
    color: "transparent"
    width: button.imageWidth + spacing + innerText.width
    height: button.imageHeight > innerText.height ? button.imageHeight : innerText.height

    signal clicked

    BorderImage{
        id: imgChecked
        anchors.left: button.left
        source: "../images/radiobutton_click.png"
        visible: button.checked
        height: imageHeight
        width: imageWidth
        smooth: true
        anchors.verticalCenter: button.verticalCenter
    }

    BorderImage{
        id: imgUnchecked
        anchors.left: button.left
        source: "../images/radiobutton.png"
        visible: !button.checked
        height: imageHeight
        width: imageWidth
        smooth: true
        anchors.verticalCenter: button.verticalCenter
    }

    Text{
        id: innerText
        anchors.left: imgChecked.right
        anchors.leftMargin: button.spacing
        enabled: button.enabled
        color: "White"
        text: "Radio Button"
        font.pixelSize: 14
        height: imageHeight
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
