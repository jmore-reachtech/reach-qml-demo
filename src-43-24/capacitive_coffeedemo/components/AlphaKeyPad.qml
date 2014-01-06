import QtQuick 1.1
import "../js/keycodes.js" as KeyCodes

Column {
    id: control
    property url normalKeyIcon: "../images/key_off.png"
    property url pressedKeyIcon: "../images/key_on.png"
    property url normalSpaceKeyIcon: "../images/key_off.png"
    property url pressedSpaceKeyIcon: "../images/key_on.png"
    property url normalBackKeyIcon: "../images/key_off.png"
    property url pressedBackKeyIcon: "../images/key_on.png"
    property int keySpacing: 10
    property int keyWidth: 28
    property int keyHeight: 40
    property bool loaded: false
    property variant popupEditor
    property color keyTextColor: "#ffffff"
    property bool keyTextBold: false
    property int keyTextFontSize: 14

    signal mouseEvent
    spacing: control.keySpacing


    Row{
        id: row1
        objectName: "row1"
        spacing: control.keySpacing
    }


    Row{
        id: row2
        objectName: "row2"
        spacing: control.keySpacing
        Item{
            width: control.keyWidth/2
            height: control.keyHeight
        }
    }


    Row{
        id: row3
        objectName: "row3"
        spacing: control.keySpacing
        Item{
            width: control.keyWidth/2
            height: control.keyHeight
        }

        Switch {
            id: switchAlt
            width: keyWidth
            height: keyHeight
            on: true
            textOff: KeyCodes.keyUpArrow
            textOn: KeyCodes.keyDownArrow
            textOnBold: keyTextBold
            textOnFontFamily: "Arial"
            textOffFontFamily: "Arial"
            textOnFontSize: keyTextFontSize
            textOffFontSize: keyTextFontSize
            imageOn: normalKeyIcon
            imageOff: normalKeyIcon
            textOnColor: "#000000"
            textOffColor: "#000000"
            textOffBold: keyTextBold

            onButtonPress: showAltCodes();
        }

    }



    Row{
        id: row4
        objectName: "row4"
        spacing: control.keySpacing
        Item{
            id: row4Spacer
            width: control.keyWidth/2
            height: control.keyHeight
        }


        Switch {
            id: switchSpecialChars
            width: keyWidth
            height: keyHeight
            on: true
            textOff: "ABC"
            textOn: "12#"
            textOnBold: keyTextBold
            textOnFontFamily: "Arial"
            textOffFontFamily: "Arial"
            textOnFontSize: keyTextFontSize
            textOffFontSize: keyTextFontSize
            imageOn: normalKeyIcon
            imageOff: normalKeyIcon
            textOnColor: keyTextColor
            textOffColor: keyTextColor
            textOffBold: keyTextBold
            onButtonPress: showSpecialChars();
        }
    }


    function showAltCodes()
    {
        if (switchAlt.on)
        {
            updateRows(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'], ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'], row1, 0, keyTextFontSize + 2);
            updateRows(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'], ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'], row2, 1, keyTextFontSize + 2);
            updateRows(['', 'z', 'x', 'c', 'v', 'b', 'n', 'm', 'Back'], ['', 'z', 'x', 'c', 'v', 'b', 'n', 'm', KeyCodes.keyBackspace], row3, 2, keyTextFontSize + 2);
        }
        else
        {
            updateRows(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], row1, 0, keyTextFontSize);
            updateRows(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], row2, 1, keyTextFontSize);
            updateRows(['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'Back'], ['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', KeyCodes.keyBackspace], row3, 2, keyTextFontSize);
        }
    }

    function showSpecialChars()
    {
        if (switchSpecialChars.on)
        {
            switchAlt.visible = false;
            row4Spacer.visible = false;
            updateRows(['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'], ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'], row1, 0, keyTextFontSize);
            updateRows(['!', '@', '#', '$', '%', '&', '*', '?', '/'], ['!', '@', '#', '$', '%', '&', '*', '?', '/'], row2, 1, keyTextFontSize);
            updateRows(['_', '"', '\'', '(', ')', '-', '+', ';', 'Back'], ['_', '"', '\'', '(', ')', '-', '+', ';', KeyCodes.keyBackspace], row3, 2, keyTextFontSize);
            updateRows([':', ',', 'Space', '.', 'Done'], [':', ',', ' ', '.', KeyCodes.keyEnter] , row4, 2);

        }
        else
        {
            updateRows(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], row1, 0, keyTextFontSize);
            updateRows(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], row2, 1, keyTextFontSize);
            updateRows(['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'Back'], ['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', KeyCodes.keyBackspace], row3, 2, keyTextFontSize);
            updateRows(['', ',', 'Space', '.', 'Done'], ['', ',', ' ', '.', KeyCodes.keyEnter] , row4, 2, keyTextFontSize);
            switchAlt.visible = true;
            row4Spacer.visible = true;
        }

    }

    function updateRows(texts, codes, parent, offset, pixelSize)
    {
        for (var i=0; i < parent.children.length; i++)
        {
            if (parent.children[i].objectName)
            {
                parent.children[i].keyCap = texts[i-offset];
                parent.children[i].keyCode = codes[i-offset];
                if (parent.children[i].keyCap !== 'Back')
                    parent.children[i].font.pixelSize = pixelSize;

                if (texts[i-offset] === '')
                {
                    parent.children[i].visible = false;
                }
                else
                {
                    parent.children[i].visible = true;
                }
            }
        }
    }

    function createKeys(texts, codes, parent)
    {
        for (var i = 0; i < texts.length; ++i)
        {
            KeyCodes.createKey(popupEditor, parent, texts[i],  codes[i], control.normalKeyIcon, control.pressedKeyIcon, control.keyHeight, control.keyWidth, control.keySpacing,
                control.keyTextColor, control.keyTextBold, control.keyTextFontSize);
        }
    }

    function createSpaceKey()
    {
        KeyCodes.createKey(popupEditor, row4, 'Space',  ' ', control.normalSpaceKeyIcon, control.pressedSpaceKeyIcon, control.keyHeight, control.keyWidth, control.keySpacing,
            control.keyTextColor, control.keyTextBold, control.keyTextFontSize);
    }

    function createBackKey(text, code, parent)
    {
        KeyCodes.createKey(popupEditor, parent, text,  code, control.normalBackKeyIcon, control.pressedBackKeyIcon, control.keyHeight, 49, control.keySpacing,
            control.keyTextColor, control.keyTextBold, control.keyTextFontSize);
    }

    Component.onCompleted: {
        createKeys(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], row1);
        createKeys(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], row2);
        createKeys(['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M'], ['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M'], row3);
        createBackKey('Back', KeyCodes.keyBackspace, row3);
        createKeys(['', ','], ['', ','], row4);
        createSpaceKey();
        createKeys(['.'], ['.'], row4);
        createBackKey('Done', KeyCodes.keyEnter, row4);
    }
}



