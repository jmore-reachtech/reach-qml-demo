import QtQuick 1.1

/*  The ImageButton demonstrates how to create a clickable image button */
/*  that changes images when pressed or clicked.                             */
/*  It consistes of two border images and a mousearea that handles the image */
/*  state changes and fires an onButtonClick event that the programmer can   */
/*  add the click event details.                                             */

Item {
    id: rectangle1
    property alias imageOn: border_image1.source
    property alias imageOff: border_image2.source
    property alias imageDis: border_image3.source
    // the text message was a way to send a message when the image button is pressed
    // in our case we need more control for the cancel and brew, so this is not implemented
    //property string textMessage: ""
    property bool disable: false

    onDisableChanged: {
        if(disable){
            border_image1.visible=false;
            border_image2.visible=false;
            border_image3.visible=true;
            mouse_area1.enabled=false;
        }
        else{
            border_image1.visible=true;
            border_image2.visible=false;
            border_image3.visible=false;
            mouse_area1.enabled=true;
        }
    }

    width: 137
    height: 126

    signal buttonClick()
    onButtonClick: {
    }

    //signal buttonTouch()
    //onButtonTouch: {
    //}

    BorderImage {
        id: border_image1
        visible: !mouse_area1.pressed
        anchors.fill: parent
        asynchronous: true
    }

    BorderImage {
        id: border_image2
        visible: mouse_area1.pressed
        anchors.fill: parent
        asynchronous: true
    }

    BorderImage {
        id: border_image3
        anchors.fill: parent
        asynchronous: true
    }

    Timer {
        id: timer
             interval: 100; running: false; repeat: false
             onTriggered: {
                 border_image1.visible = true;
                 border_image2.visible = false;
                 rectangle1.scale = 1.0
                 buttonClick();
             }
    }

    MouseArea {
        id: mouse_area1
        anchors.fill: parent
        onClicked: {
            border_image1.visible = false;
            border_image2.visible = true;
            timer.start();
        }
        onPressed: {
            rectangle1.scale = 1.04
            border_image1.visible = false;
            border_image2.visible = true;
        }
        onReleased: {
            rectangle1.scale = 1.04
        }
    }


}
