import QtQuick 1.0

Rectangle {
    id: root
    property alias imageOn: border_image1.source
    property alias imageOff: border_image2.source
    property alias textOn: textOn.text
    property alias textOnFontFamily: textOn.font.family
    property alias textOnFontSize: textOn.font.pixelSize
    property alias textOnColor: textOn.color
    property alias textOnBold: textOn.font.bold
    property alias textOff: textOff.text
    property alias textOffFontFamily: textOff.font.family
    property alias textOffFontSize: textOff.font.pixelSize
    property alias textOffColor: textOff.color
    property alias textOffBold: textOff.font.bold
    property bool on : false
    property string value : ""
    color: "Transparent"

    width: 64
    height:64

    signal buttonClick()
    onButtonClick: {
        on = !on;
    }

    signal buttonPress()
    onButtonPress: {
    }

    signal buttonRelease()
    onButtonRelease: {
    }

    BorderImage {
        id: border_image1
        visible: on
        anchors.fill: parent
        opacity: !root.disabled ? 1.0 : 0.5
    }

    BorderImage {
        id: border_image2
        visible: !on
        anchors.fill: parent
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: buttonClick()
        onPressed: buttonPress()
        onReleased: buttonRelease()
    }

    Text {
        id: textOn
        text: "On"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.pixelSize: 12
        visible: on
        color: textOnColor
    }

    Text {
        id: textOff
        text: "Off"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.pixelSize: 12
        visible: !on
        color: textOffColor
    }

}
