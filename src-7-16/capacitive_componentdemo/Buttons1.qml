import QtQuick 1.1
import "../components"

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
                image_off: "../capacitive_componentdemo/images/switchgroupup.png"
                val: "1"
                text_off: "1"
                image_on: "../capacitive_componentdemo/images/switchgroupdown.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "2"
                image_off: "../capacitive_componentdemo/images/switchgroupup.png"
                val: "2"
                text_off: "2"
                image_on: "../capacitive_componentdemo/images/switchgroupdown.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "3"
                image_off: "../capacitive_componentdemo/images/switchgroupup.png"
                val: "3"
                text_off: "3"
                image_on: "../capacitive_componentdemo/images/switchgroupdown.png"
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
                image_off: "../capacitive_componentdemo/images/switchgroupup.png"
                val: "A"
                text_off: "A"
                image_on: "../capacitive_componentdemo/images/switchgroupdown2.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "B"
                image_off: "../capacitive_componentdemo/images/switchgroupup.png"
                val: "B"
                text_off: "B"
                image_on: "../capacitive_componentdemo/images/switchgroupdown2.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "C"
                image_off: "../capacitive_componentdemo/images/switchgroupup.png"
                val: "C"
                text_off: "C"
                image_on: "../capacitive_componentdemo/images/switchgroupdown2.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "D"
                image_off: "../capacitive_componentdemo/images/switchgroupup.png"
                val: "D"
                text_off: "D"
                image_on: "../capacitive_componentdemo/images/switchgroupdown2.png"
                item_width: 60
                item_height: 60
            }
            ListElement {
                text_on: "E"
                image_off: "../capacitive_componentdemo/images/switchgroupup.png"
                val: "E"
                text_off: "E"
                image_on: "../capacitive_componentdemo/images/switchgroupdown2.png"
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
        x: 59
        y: 365
        width: 48
        height: 48
        text: ""
        imageDown: "images/quit_down.png"
        imageUp: "images/quit_up.png"
        onButtonClick: parent.parent.parent.message("../src/mainmenu.qml");
    }

    Rectangle{
        id: rectOpaque
        gradient: Gradient {
            GradientStop {position: 0.0; color: "#666666"}
            GradientStop {position: 1.0; color: "#EEEEEE"}
        }
        width: 800
        height: 480
        opacity: 0.2

        Rectangle{
            id: rectMessage
            x: 68
            y: 84
            radius: 10
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            border.width: 2
            opacity: 1.0
            border.color: "#0f0f0e"
            height: 104
            width: 344
            smooth: true
            anchors.centerIn: parent
            gradient: Gradient {
                GradientStop {position: 0.0; color: "#2D2D2D"}
                GradientStop {position: 1.0; color: "#666666"}
            }

            Text{
                id: txtMessage
                height: 43
                color: "#ffffff"
                text: "Swipe right or left to change pages."
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: image1
                x: 0
                y: 31
                width: 50
                height: 43
                smooth: true
                source: "images/leftarrow.png"
                anchors.right: txtMessage.left
            }

            Image {
                id: image2
                x: 281
                y: 31
                width: 50
                height: 43
                source: "images/rightarrow.png"
                anchors.left: txtMessage.right
            }


        }

        MouseArea{
            anchors.fill: parent
            onClicked: {rectOpaque.visible = false;}
        }

    }

    PropertyAnimation {
        id: showAnim
        target: rectOpaque
        property: "opacity"
        duration: 2000
        easing.type: Easing.InOutQuad
    }


    Component.onCompleted: {
        showAnim.from = 0.2;
        showAnim.to = 1.0;
        showAnim.start();
        var src1 = "import QtQuick 1.1; Timer {id: timer1; interval: 3000; running: false; repeat: false; onTriggered:{rectOpaque.visible = false;} }";
        var timer1 = Qt.createQmlObject(src1, button1, "timerObject1");
        timer1.start();


    }
}
