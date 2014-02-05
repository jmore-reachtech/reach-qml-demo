// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../js/keycodes.js" as KeyCodes

Item {
    id: popupEditor

    property int animationSpeed: 100
    property string keyBACKSPACE: "\b"
    property string keyENTER: "\n"
    property alias bgImage: bgImage.source
    property alias label: labelItem
    property alias text: textItem
    property alias font: textItem.font
    property variant rootObject
    property url normalKeyIcon: "../images/key_off.png"
    property url pressedKeyIcon: "../images/key_on.png"
    property url normalSpaceKeyIcon: "../images/key_off.png"
    property url pressedSpaceKeyIcon: "../images/key_on.png"
    property url normalBackKeyIcon: "../images/key_off.png"
    property url pressedBackKeyIcon: "../images/key_on.png"
    property int keyWidth: 38
    property int keyHeight: 40
    property bool showHint: true
    property int hintDuration: 500
    property bool loaded: false
    property string keyTextColor: "#000000"
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
        if (key === KeyCodes.keyBackspace) {
            if (text.text.length)
                text.text = text.text.substring(0, text.text.length-1);
        }
        else if (key !== KeyCodes.keyEnter)
            text.text += key;
        keyPress(key);
    }

    function showKeyHint(keyCode)
    {
        if (popupEditor.showHint && keyCode != " " && keyCode != KeyCodes.keyBackspace
                && keyCode != KeyCodes.keyEnter)
        {
            recHint.text = keyCode;
            recHint.visible = true;
            timerHint.start();
        }
    }

    Timer{
        id: timerHint
        interval : popupEditor.hintDuration
        repeat : false
        running : false
        onTriggered: recHint.visible = false;
    }

    width: content.width
    height: content.height

   MouseArea{
       anchors.fill: parent
   }

   Image {
       id: bgImage
       source: "../images/keyboardbg.png"
       anchors.fill: parent
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

           AlphaKeyPad {
               id: alphaKeyPad
               anchors.left: labelItem.left
               anchors.leftMargin: 0
               anchors.top: labelItem.bottom
               anchors.topMargin: 10
               normalKeyIcon: popupEditor.normalKeyIcon
               pressedKeyIcon: popupEditor.pressedKeyIcon
               normalSpaceKeyIcon: popupEditor.normalSpaceKeyIcon
               pressedSpaceKeyIcon: popupEditor.pressedSpaceKeyIcon
               normalBackKeyIcon: popupEditor.normalBackKeyIcon
               pressedBackKeyIcon: popupEditor.pressedBackKeyIcon
               keySpacing: 4
               keyWidth: popupEditor.keyWidth
               keyHeight: popupEditor.keyHeight
               popupEditor: parent.parent.parent
               keyTextColor: popupEditor.keyTextColor
               keyTextBold: popupEditor.keyTextBold
               keyTextFontSize: popupEditor.keyTextFontSize
           }

           Rectangle{
               id: recHint
               color: "#000000"
               height: 40
               width: 38
               radius: 6
               property alias text: txtHint.text
               visible: false;
               anchors.left: alphaKeyPad.right
               anchors.leftMargin: 10
               anchors.top: alphaKeyPad.top


               Text{
                   id: txtHint
                   color: "#fbfafa"
                   text: ""
                   font.pixelSize: 20
                   anchors.fill: parent
                   verticalAlignment: Text.AlignVCenter
                   horizontalAlignment: Text.AlignHCenter

               }
           }

        }

   }

   PropertyAnimation {
        id: showAnim

        target: popupEditor
        property: "y"
        duration: animationSpeed

        onCompleted: {
            timer.start();
        }
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

    Timer{
        id:timer
        repeat: false
        interval: 100
        onTriggered: alphaKeyPad.loaded = true;
    }

}