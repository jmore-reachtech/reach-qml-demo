import QtQuick 1.1
import "../js/datePicker.js" as Ops

Keyboard
{
    id:dkb
    property color fontColor:  "black"
    property int keyHeight: 22
    property int keyWidth:  22
    property string keyImageSource:  "../images/key.png"
    property string keyFontFamily: "Arial"
    property string highLightColor:  "Yellow"


    //Set up the keyboard keys and the text values
    Column {
        id: dkc;
        anchors {
            horizontalCenter: parent.horizontalCenter
            margins: 0
        }

        spacing: 0

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton {id:prevMonth; fontFamily: keyFontFamily; source: keyImageSource; height:keyHeight; width:keyWidth; text: leftArrow; textColor: fontColor; onClicked: Ops.refreshDatePicker(-1)}

            Text{id:monthLabel; width:194; height:keyHeight; font.bold: true; font.family: keyFontFamily;
                font.pixelSize: 16; horizontalAlignment:Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }

            KeyboardButton {id:nextMonth; fontFamily: keyFontFamily; source: keyImageSource; height:keyHeight; width:keyWidth; text: rightArrow; textColor: fontColor; onClicked: Ops.refreshDatePicker(1)}
        }
        Row {
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton {source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: "Su"; textColor: fontColor}
            KeyboardButton {source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: "Mo"; textColor: fontColor}
            KeyboardButton {source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: "Tu"; textColor: fontColor}
            KeyboardButton {source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: "We"; textColor: fontColor}
            KeyboardButton {source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: "Th"; textColor: fontColor}
            KeyboardButton {source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: "Fr"; textColor: fontColor}
            KeyboardButton {source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: "Sa"; textColor: fontColor}
        }
        Row {
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton {id:day0; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day1; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day2; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day3; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day4; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day5; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day6; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
        }
        Row {
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton {id:day7; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day8; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day9; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day10; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day11; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day12; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day13; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
        }
        Row {
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton {id:day14; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day15; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day16; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day17; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day18; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day19; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day20; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
        }
        Row {
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton {id:day21; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day22; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day23; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day24; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day25; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day26; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day27; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
        }
        Row {
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton {id:day28; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day29; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day30; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day31; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day32; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day33; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day34; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
        }
        Row { id:lastRow
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton {id:day35; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day36; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day37; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day38; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day39; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day40; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton {id:day41; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; text: ""; op: ""; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
        }


    }

    // Depending on the parent's focus, set the initial state
    state: parent.activeFocus ? "active" : "inactive"
    states: [
        State {
            name: "active"
            PropertyChanges { target: dkb; y: (surface.height - dkc.height); }
        },
        State {
            name: "inactive"
            PropertyChanges { target: dkb; y: surface.height + 8; }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            target: dkb
            property: "y"
            easing.type: "OutQuad"
            duration: 250
        }
    }

    Component.onCompleted: {Ops.refreshDatePicker(0);}
}
