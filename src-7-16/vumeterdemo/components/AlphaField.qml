// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../js/keycodes.js" as KeyCodes

Rectangle {
    id: control

    property alias label: labelItem
    property alias input: textItem
    property int fieldSpacing: 6
    property url normalKeyIcon: "../images/key_off.png"
    property url pressedKeyIcon: "../images/key_on.png"
    property url normalSpaceKeyIcon: "../images/key_off.png"
    property url pressedSpaceKeyIcon: "../images/key_off.png"
    property int keyWidth: 38
    property int keyHeight: 40
    property url keyboardBackGroundImage: "../images/keyboardbg.png"
    property int keyboardAnimationSpeed: 100
    property string keyTextColor: "#ffffff"
    property alias labelText: labelItem.text
    property alias labelColor: labelItem.color
    property alias labelFontFamily: labelItem.font.family
    property alias labelFontPixelSize: labelItem.font.pixelSize
    property alias labelFontPointSize: labelItem.font.pointSize
    property alias labelFontBold: labelItem.font.bold
    property alias labelFontItalic: labelItem.font.italic
    property alias labelFontUnderline: labelItem.font.underline
    property alias labelFontStrikeout: labelItem.font.strikeout

    property alias inputText: textItem.text
    property alias inputColor: textItem.color
    property alias inputFontFamily: textItem.font.family
    property alias inputFontPixelSize: textItem.font.pixelSize
    property alias inputFontPointSize: textItem.font.pointSize
    property alias inputFontBold: textItem.font.bold
    property alias inputFontItalic: textItem.font.italic
    property alias inputFontUnderline: textItem.font.underline
    property alias inputFontStrikeout: textItem.font.strikeout

    color: "Transparent"

    width: labelItem.width + textItem.width + fieldSpacing
    height: Math.max(labelItem.font.pixelSize, textItem.height + 4)
    clip: true

    Row {
        id: content
        height: parent.height;
        spacing: control.fieldSpacing

        Text {
            id: labelItem
            text: "Label"
            font.pixelSize: 12
            anchors.verticalCenter: parent.verticalCenter

        }

        LineEdit{
            id: textItem
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
            width: control.width - labelItem.width - fieldSpacing
        }
    }


    MouseArea {
        anchors.fill: parent
        z: 100

        onReleased: {
            var rootObject = control.parent;
            var keypad = popupEditor.createObject(control);
            if (keypad) {
                keypad.label.text = label.text;
                keypad.text.text = input.text;
                keypad.show();
            }
        }
    }

    Component {
        id: popupEditor

        PopupAlphaEditor {
            label.font: labelItem.font
            label.color: labelItem.color
            font: input.font
            text.width: input.width
            normalKeyIcon: control.normalKeyIcon
            pressedKeyIcon: control.pressedKeyIcon
            normalSpaceKeyIcon: control.normalSpaceKeyIcon
            pressedSpaceKeyIcon: control.pressedSpaceKeyIcon
            keyWidth: control.keyWidth
            keyHeight: control.keyHeight
            bgImage: control.keyboardBackGroundImage
            animationSpeed: control.keyboardAnimationSpeed
            keyTextColor: control.keyTextColor

            onKeyPress: {
                if (key === KeyCodes.keyBackspace) {
                    if (input.text.length)
                        input.text = input.text.substring(0,input.text.length-1);
                } else if (key === KeyCodes.keyEnter)
                    hide();
                else
                    input.text += key;
            }
        }

    }



}
