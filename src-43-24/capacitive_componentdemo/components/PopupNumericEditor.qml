// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../js/keycodes.js" as KeyCodes

Item {
    id: popupEditor

    property int animationSpeed: 200
    property string keyBACKSPACE: "\b"
    property string keyENTER: "\n"
    property alias bgImage: bgImage.source
    property alias label: labelItem
    property alias text: textItem
    property alias font: textItem.font
    property variant rootObject
    property url normalKeyIcon: "../images/key_off.png"
    property url pressedKeyIcon: "../images/key_on.png"
    property int keyWidth: 38
    property int keyHeight: 40
    property real min
    property real max
    property color keyTextColor : "#ffffff"
    property bool keyTextBold: false
    property int keyTextFontSize: 14

    signal keyPress(string key)

    function show()
    {
        rootObject = popupEditor.parent;
        while (rootObject.parent)
            rootObject = rootObject.parent;

        //hide all child components
        //for(var i=0; i < rootObject.children.length; i++)
        //    rootObject.children[i].visible = false;


        popupEditor.parent = rootObject;
        popupEditor.width = rootObject.width;
        popupEditor.height = rootObject.height;
        popupEditor.x = 0;//(rootObject.width - background.width)/2
        popupEditor.y = 0;
        showAnim.from = rootObject.height;
        showAnim.to = 0//rootObject.height-background.height;
        showAnim.start();
    }

    function hide()
    {
        hideAnim.start();
        //show all child components
        //for(var i=0; i < rootObject.children.length; i++)
        //    rootObject.children[i].visible = true;
    }

    function handleKeyPress(key)
    {
        var error = false;
        txtMessage.text = "";

        if (key === KeyCodes.keyBackspace) {
            if (text.text.length)
                text.text = text.text.substring(0, text.text.length-1);
        }
        else if (key === "-")
        {
            if (text.text.length === 0)
                text.text += key;
            else
                error = true;
        }
        else if (key !== KeyCodes.keyEnter)
            text.text += key;
        else if (key === KeyCodes.keyEnter)
        {

            if (text.text === "-")
            {
                txtMessage.text = "Please enter a valid number.";
                error = true;
            }
            else if (parseFloat(text.text) > max)
            {
                txtMessage.text = labelItem.text + " can not be greater than " + max.toString();
                error = true;
            }
            else if (parseFloat(text.text) < min)
            {
                txtMessage.text = labelItem.text + " can not be less than " + min.toString();
                error = true;
            }
        }

        if (!error)
            keyPress(key);
    }

    width: content.width
    height: content.height

    MouseArea{
        anchors.fill: parent
    }

   Image {
       id: bgImage
       source: "../images/keyboardbg.png"
   }

   Column {
       Item {
           id: content
           width: 466
           height: Math.max(labelItem.font.pixelSize, textItem.font.pixelSize) + 20

           Text {
               id: labelItem
               anchors.left: parent.left
               anchors.leftMargin: 10
               anchors.verticalCenter: parent.verticalCenter
               text: popupEditor.label.text
               font: popupEditor.label.font
               color: popupEditor.label.color
           }

           LineEdit {
               id: textItem
               anchors.left: labelItem.right
               anchors.leftMargin: 6//content.height / 2
               anchors.verticalCenter: parent.verticalCenter
               width: parent.width - labelItem.width - content.height / 2
               text: popupEditor.text.text
               font: popupEditor.text.font
               color: popupEditor.text.color
               focus: true
               border.color: "orange"
               cursorVisible: true;
           }

           Text{
               id: txtMessage
               text: ""
               anchors.right: textItem.right
               anchors.rightMargin: 4
               anchors.top: textItem.bottom
               anchors.topMargin: 4
               font: popupEditor.label.font
               color: "red"
           }

           NumericKeyPad {
               id: keyPad
               anchors.left: textItem.left
               anchors.leftMargin: 0
               anchors.top: labelItem.bottom
               anchors.topMargin: 4
               normalKeyIcon: popupEditor.normalKeyIcon
               pressedlKeyIcon: popupEditor.pressedKeyIcon
               keySpacing: 4
               keyWidth: popupEditor.keyWidth
               keyHeight: popupEditor.keyHeight
               keyTextColor: popupEditor.keyTextColor
               keyTextBold: popupEditor.keyTextBold
               keyTextFontSize: popupEditor.keyTextFontSize
               keyDefs: [
                   {keyCap: '1', keyCode: '1'},
                   {keyCap: '2', keyCode: '2'},
                   {keyCap: '3', keyCode: '3'},
                   {keyCap: '4', keyCode: '4'},
                   {keyCap: '5', keyCode: '5'},
                   {keyCap: '6', keyCode: '6'},
                   {keyCap: '7', keyCode: '7'},
                   {keyCap: '8', keyCode: '8'},
                   {keyCap: '9', keyCode: '9'},
                   {keyCap: '0', keyCode: '0'},
                   {keyCap: '-', keyCode: '-'},
                   {keyCap: 'Back', keyCode: KeyCodes.keyBackspace},
                   {keyCap: 'Done', keyCode: KeyCodes.keyEnter}
               ]
           }

        }

   }

   PropertyAnimation {
        id: showAnim

        target: popupEditor
        property: "y"
        duration: animationSpeed
    }

    SequentialAnimation {
        id: hideAnim

        PropertyAnimation {
            target: popupEditor
            property: "y"
            to: popupEditor.parent.height
            duration: animationSpeed
        }
        ScriptAction {
            script: popupEditor.destroy()
        }
    }
}

