import QtQuick 1.1
import "../components"

Rectangle {
    id: root
    objectName: "root"
    width: 480
    height: 272
    property int activeLow: 0
    property int activeHigh: 1

    gradient: Gradient {
        GradientStop {
            position: 0.16
            color: "#afacac"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }

    signal message(string msg)

    Text {
        id: txtTitle
        x: 0
        y: 9
        width: 480
        height: 29
        text: qsTr("GPIO Plugin Demo")
        anchors.horizontalCenterOffset: 0
        horizontalAlignment: Text.AlignHCenter
        font.bold: false
        font.pixelSize: 21
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Switch{
        id: switch_pin0
        x: 91
        y: 58
        width: 130
        height: 37
        textOffBold: true
        textOnBold: true
        textOff: "GP 0 Low"
        textOn: "GP 0 High"
        imageOff: "../images/internal_button_up.bmp"
        imageOn: "../images/internal_button_dn.bmp"
        on: false;

        onOnChanged: {
            if (on)
                pin0.writeToPin(activeHigh);
            else
                pin0.writeToPin(activeLow);
        }
    }

    Switch {
        id: switch_pin1
        x: 91
        y: 107
        width: 130
        height: 37
        textOff: "GP 1 Low"
        textOn: "GP 1 High"
        imageOn: "../images/internal_button_dn.bmp"
        imageOff: "../images/internal_button_up.bmp"
        textOffBold: true
        textOnBold: true;
        on: false

        onOnChanged: {
            if (on)
                pin1.writeToPin(activeHigh);
            else
                pin1.writeToPin(activeLow);
        }
    }

    Switch{
        id: switch_pin2
        x: 91
        y: 155
        width: 130
        height: 37
        textOffBold: true
        textOnBold: true
        textOff: "GP 2 Low"
        textOn: "GP 2 High"
        imageOff: "../images/internal_button_up.bmp"
        imageOn: "../images/internal_button_dn.bmp"
        on: false;

        onOnChanged: {
            if (on)
                pin2.writeToPin(activeHigh);
            else
                pin2.writeToPin(activeLow);
        }
    }

    Switch{
        id: switch_pin3
        x: 91
        y: 204
        width: 130
        height: 37
        textOffBold: true
        textOnBold: true
        textOff: "GP 3 Low"
        textOn: "GP 3 High"
        imageOff: "../images/internal_button_up.bmp"
        imageOn: "../images/internal_button_dn.bmp"
        on: false;

        onOnChanged: {
            if (on)
                pin3.writeToPin(activeHigh);
            else
                pin3.writeToPin(activeLow);
        }
    }

    ImageButton{
            id:nextButton
            x: 390
            y: 124
            width: 48
            height: 48
            text: ""
            imageDown: "images/next_down.png"
            imageUp: "images/next_up.png"

            onButtonClick: {
                root.message("gpiodemo/inputpins.qml");
            }
    }

    ImageButton {
        id: quitButton
        x: 390
        y: 187
        width: 48
        height: 48
        text: ""
        imageDown: "../images/quit_down.png"
        imageUp: "../images/quit_up.png"
        onButtonClick: root.message("../src/mainmenu.qml");
    }

    GPIOPinOutput{
        id: pin0
        pin: 0
    }

    GPIOPinOutput{
        id: pin1
        pin: 1
    }

    GPIOPinOutput{
        id: pin2
        pin: 2
    }

    GPIOPinOutput{
        id: pin3
        pin: 3
    }

    GPIOPinInput{
        id: pin4
        pollPin: true
        pin: 4
        onStateChanged:{
            if (state == activeHigh)
                txtGPIO4.text = "GP 4 High";
            else
                txtGPIO4.text = "GP 4 Low";
        }
    }

    GPIOPinInput{
        id: pin5
        pollPin: true
        pin: 5
        onStateChanged:{
            if (state == activeHigh)
                txtGPIO5.text = "GP 5 High";
            else
                txtGPIO5.text = "GP 5 Low";
        }
    }

    GPIOPinInput{
        id: pin6
        pollPin: true
        pin: 6
        onStateChanged:{
            if (state == activeHigh)
                txtGPIO6.text = "GP 6 High";
            else
                txtGPIO6.text = "GP 6 Low";
        }
    }

    GPIOPinInput{
        id: pin7
        pollPin: true
        pin: 7
        onStateChanged:{
            if (state == activeHigh)
                txtGPIO7.text = "GP 7 High";
            else
                txtGPIO7.text = "GP 7 Low";
        }
    }

    Text {
        id: txtGPIO4
        x: 255
        y: 64
        width: 96
        height: 25
        color: "#ffffff"
        text: qsTr("GP 4 Low")
        font.pixelSize: 18
    }

    Text {
        id: txtGPIO5
        x: 255
        y: 113
        width: 96
        height: 25
        color: "#ffffff"
        text: qsTr("GP 5 Low")
        font.pixelSize: 18
    }

    Text {
        id: txtGPIO6
        x: 255
        y: 161
        width: 96
        height: 25
        color: "#ffffff"
        text: qsTr("GP 6 Low")
        font.pixelSize: 18
    }

    Text {
        id: txtGPIO7
        x: 255
        y: 210
        width: 96
        height: 25
        color: "#ffffff"
        text: qsTr("GP 7 Low")
        font.pixelSize: 18
    }


    Component.onCompleted: {
        if (pin0.readPin() == activeHigh)
		    switch_pin0.on = true;
        if (pin1.readPin() == activeHigh)
            switch_pin1.on = true;
        if (pin2.readPin() == activeHigh)
            switch_pin2.on = true;
        if (pin3.readPin() == activeHigh)
            switch_pin3.on = true;
    }
}
