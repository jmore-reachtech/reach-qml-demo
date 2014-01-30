import QtQuick 1.1
import "components"

Rectangle {
    id: button1
    objectName: "button1"
    width: 800
    height: 480
    signal message(string msg)

    Image{
        source: "../images/bg.png"
        anchors.fill: parent
    }

    Text {
        id: txtTitle
        x: 276
        y: 66
        text: qsTr("Buttons and Switches")
        font.bold: false
        font.pixelSize: 26
    }

    ImageButton {
        id: image_button1
        x: 423
        y: 146
        width: 102
        height: 102
        text: ""
        imageUp: "images/btn_off2.png"
        font.pixelSize: 18
        textColor: "#000000"
        imageDown: "images/btn_on2.png"
        font.bold: false
        font.family: "Arial"

        onButtonPress: {
            console.debug("Button Pressed.");
        }
    }


    Switch {
        id: switch1
        x: 154
        y: 129
        width: 49
        height: 135
        on: false
        textOff: ""
        textOn: ""
        textOnBold: false
        textOnFontFamily: "Arial"
        textOffFontFamily: "Arial"
        textOnFontSize: 14
        textOffFontSize: 14
        imageOn: "images/switch_on.png"
        imageOff: "images/switch_off.png"
        textOnColor: "#000000"
        textOffColor: "#000000"
        textOffBold: false

        onOnChanged: {
            console.debug(on)
        }
    }

    Switch {
        id: switch2
        x: 276
        y: 162
        width: 70
        height: 70
        on: false
        textOff: ""
        textOn: ""
        textOnBold: false
        textOnFontFamily: "Arial"
        textOffFontFamily: "Arial"
        textOnFontSize: 14
        textOffFontSize: 14
        imageOn: "images/btn_on.png"
        imageOff: "images/btn_off.png"
        textOnColor: "#000000"
        textOffColor: "#000000"
        textOffBold: false

        onOnChanged: {
            console.debug(on)
        }
    }

    VerticalSwitchGroup {
        id: switch_group2
        x: 607
        y: 129
        height: 2
        spacing: 4
        font.underline: false
        font.pixelSize: 20
        font.family: "Arial"
        font.bold: true
        model: ListModel {
            ListElement {
                text_on: "1"
                image_off: "../images/switchgroupup.png"
                val: "1"
                text_off: "1"
                image_on: "../images/switchgroupdown.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "2"
                image_off: "../images/switchgroupup.png"
                val: "2"
                text_off: "2"
                image_on: "../images/switchgroupdown.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "3"
                image_off: "../images/switchgroupup.png"
                val: "3"
                text_off: "3"
                image_on: "../images/switchgroupdown.png"
                item_width: 60
                item_height: 60
            }
        }

        textOnColor: "#000000"
        textOffColor: "#000000"

        onValueChanged: console.debug(value);
    }


    HorizontalSwitchGroup {
        id: switch_group3
        x: 237
        y: 301
        font.pixelSize: 16
        spacing: 4
        font.family: "Arial"
        font.bold: true
        model: ListModel {
            ListElement {
                text_on: "A"
                image_off: "../images/switchgroupup.png"
                val: "A"
                text_off: "A"
                image_on: "../images/switchgroupdown2.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "B"
                image_off: "../images/switchgroupup.png"
                val: "B"
                text_off: "B"
                image_on: "../images/switchgroupdown2.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "C"
                image_off: "../images/switchgroupup.png"
                val: "C"
                text_off: "C"
                image_on: "../images/switchgroupdown2.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "D"
                image_off: "../images/switchgroupup.png"
                val: "D"
                text_off: "D"
                image_on: "../images/switchgroupdown2.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "E"
                image_off: "../images/switchgroupup.png"
                val: "E"
                text_off: "E"
                image_on: "../images/switchgroupdown2.png"
                item_width: 60
                item_height: 60
            }
        }
        textOnColor: "#000000"
        textOffColor: "#000000"

        onValueChanged: console.debug(value);
    }


    ImageButton {
        id: quitButton
        x: 30
        y: 365
        width: 48
        height: 48
        text: ""
        imageDown: "images/quit_down.png"
        imageUp: "images/quit_up.png"
        onButtonClick: parent.parent.parent.message("../src/mainmenu.qml");
    }

    Component.onCompleted: {

    }
}
