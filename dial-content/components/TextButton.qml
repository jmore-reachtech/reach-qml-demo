import QtQuick 1.0

Item {
    id: item
    property color hoverColor: "gold";
    property color hoverTextColor: "limegreen";
    property color buttonColor: "red";
    property string text: "Submit";
    property color textColor: "white";
    property string textFontFamily: "Verdana";
    property int textPixelSize: 12;
    property bool textBold: true;
    property int buttonRadius: 6;
    property int buttonBorderWidth: 1;
    property color buttonBorderColor: "black";

    width: 96;
    height: 24;

    signal buttonClick()
    onButtonClick: {
    }

    Rectangle {
        id: button
        anchors.fill: parent
        color: parent.buttonColor;
        radius: parent.buttonRadius;
        border.width: parent.buttonBorderWidth;
        border.color: parent.buttonBorderColor;
        width: parent.width;
        height: parent.height;
        smooth: true

        Text{
            id: buttonLabel
            anchors.centerIn: parent
            color: parent.parent.textColor
            text: parent.parent.text
            style: Text.Raised
            font.bold: parent.parent.textBold;
            font.pixelSize: parent.parent.textPixelSize;
            font.family: parent.parent.textFontFamily;
        }

        MouseArea {
            id: mousearea1
            anchors.fill: parent
            onClicked: buttonClick()
            onPressed: buttonClick()
            hoverEnabled: true;
            onEntered: {
                parent.color = hoverColor;
                buttonLabel.color = hoverTextColor;
            }
            onExited: {
                parent.color = buttonColor;
                buttonLabel.color = textColor;
            }
        }
    }


}

