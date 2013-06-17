import QtQuick 1.1

Keyboard
{
    id:nkb
    property color fontColor:  "black"
    property int keyHeight: 34
    property int keyWidth:  24
    property string keyImageSource:  "../images/key.png"
    property string keyFontFamily: "Arial"

    //Set up the keyboard keys and the text values
    Column {
        id: nkc;
        anchors {
            horizontalCenter: parent.horizontalCenter
            margins: 4
        }

        spacing: 6

        Row {
            spacing: 6
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton { text: "1"; op: "1"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton { text: "2"; op: "2"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton { text: "3"; op: "3"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton { text: "4"; op: "4"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
        }
        Row {
            spacing: 6
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton { text: "5"; op: "5"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton { text: "6"; op: "6"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton { text: "7"; op: "7"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton { text: "8"; op: "8"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
        }
        Row {
            spacing: 6
            anchors.horizontalCenter: parent.horizontalCenter
            KeyboardButton { text: "9"; op: "9"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton { text: "0"; op: "0" ; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed)}
            KeyboardButton { text: "."; op: "."; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed) }
            KeyboardButton { text: "-"; op: "-"; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed) }
            KeyboardButton { text: leftArrow; op:leftArrow; source: keyImageSource; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; Component.onCompleted: clicked.connect(buttonPressed) }
        }
        Row {
            spacing: 6
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    // Depending on the parent's focus, set the initial state
    state: parent.activeFocus ? "active" : "inactive"
    states: [
        State {
            name: "active"
            PropertyChanges { target: nkb; y: (surface.height - nkc.height); }
        },
        State {
            name: "inactive"
            PropertyChanges { target: nkb; y: surface.height + 8; }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            target: nkb
            property: "y"
            easing.type: "OutQuad"
            duration: 250
        }
    }


}

