import QtQuick 1.0

Keyboard {
    id:vkb
    property bool upperCase: false
    property bool alt: false
    property color fontColor:  "white"
    property int keyHeight: 34
    property int keyWidth:  24
    property string keyImageSource:  "../images/key.png"
    property string keyFontFamily: "Arial"
    property color altColor:  "Yellow"

    signal keyEvent(string event);

    // Function to handle when user wants to use uppercase characters
    function upperCasePressed()
    {
        var offSet = -32;

        if (upperCase)
        {
            upperCase = false;
            offSet = 32;
            upperCaseKey.textColor = "gray";
        }
        else
        {
            upperCase = true;
            upperCaseKey.textColor = altColor;
        }

        for(var i=0; i < 10; i++)
        {
            row1.children[i].text = row1.children[i].op = String.fromCharCode(row1.children[i].text.charCodeAt(0) + offSet);
        }

        for(i=0; i < 9; i++)
        {
            row2.children[i].text = row2.children[i].op = String.fromCharCode(row2.children[i].text.charCodeAt(0) + offSet);
        }

        for(i=0; i < 7; i++)
        {
            row3.children[i].text = row3.children[i].op = String.fromCharCode(row3.children[i].text.charCodeAt(0) + offSet);
        }

    }


    // Function to handle when the user presses the 'alk'key
    function altPressed()
    {
        if (alt)
        {
            alt = false;
            altKey.textColor = "white";
            for(var i=0; i < 10; i++)
            {
                row1.children[i].op = row1.children[i].text;
            }

            for(i=0; i < 9; i++)
            {
                row2.children[i].op = row2.children[i].text;
            }

            for(i=0; i < 7; i++)
            {
                row3.children[i].op = row3.children[i].text;
            }
        }
        else
        {
            alt = true;
            altKey.textColor = altColor;
            for(var i=0; i < 10; i++)
            {
                row1.children[i].op = row1.children[i].shiftText;
            }

            for(i=0; i < 9; i++)
            {
                row2.children[i].op = row2.children[i].shiftText;
            }

            for(i=0; i < 7; i++)
            {
                row3.children[i].op = row3.children[i].shiftText;
            }

        }
    }

    //Function to close the keyboard
    function close(){
        vkb.state = "inactive"
    }
    //Set up the keyboard keys and the text values
    Column {
        id: vkc;
        anchors {
            horizontalCenter: parent.horizontalCenter
            margins: 4
        }

        spacing: 6

        Row {
            id: row1
            spacing: 6
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row {
            id: row2
            spacing: 6
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row {
            id: row3
            spacing: 6
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row {
            spacing: 6
            anchors.horizontalCenter: parent.horizontalCenter
            Key {id:upperCaseKey; text: upperArrow; op: upperArrow ; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: "gray"; onClicked: upperCasePressed()}
            Key {id:altKey; text: "Alt"; op: "" ; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: "gray"; onClicked: altPressed()}
            Key {keyboard: vkb; width: 150; text: "_"; op: " "; fontFamily: keyFontFamily; height: keyHeight; textColor: fontColor; }
            Key {keyboard: vkb; text: "."; op: ".";  fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; }
            Key {keyboard: vkb; text: leftArrow; op: leftArrow;  fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; }
            Key {keyboard: vkb; width: 70; text: "done"; op: "done";  fontFamily: keyFontFamily; height: keyHeight; textColor: fontColor;}
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
            PropertyChanges { target: vkb; y: (surface.height - vkc.height); }
        },
        State {
            name: "inactive"
            PropertyChanges { target: vkb; y: surface.height + 8; }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            target: vkb
            property: "y"
            easing.type: "OutQuad"
            duration: 250
        }
    }

    function createKeys(texts, ops, shiftTexts, shiftOps, parent)
    {
        for (var i = 0; i < texts.length; ++i)
        {
            var object = Qt.createQmlObject('Key {objectName:"' + texts[i] + '"; keyboard:vkb; text: "' + texts[i] + '"; op: "' + ops[i] + '"; shiftText: "' + shiftTexts[i] + '"; shiftOp: "' + shiftOps[i] + '"; fontFamily: keyFontFamily; height: keyHeight; width: keyWidth; textColor: fontColor; }', parent);
        }
    }

    function buildKeyboard() {
        createKeys(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'], ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'], ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'], ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'], row1);
        createKeys(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'], ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'], ['@', '#', '%', '&', '*', '-', '+', '=', '/'], ['a', 's', 'd', 'f', 'g', 'h', '+', '-', '/'], row2);
        createKeys(['z', 'x', 'c', 'v', 'b', 'n', 'm'], ['z', 'x', 'c', 'v', 'b', 'n', 'm'], ['_', '$', '^', '', '\'', ':', ';'] , ['_', '$', '%', '&', '*', '-', '+'], row3);

    }

}
