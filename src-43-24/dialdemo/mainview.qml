import QtQuick 1.1
import "../components"

Rectangle {
    id: rootDial
    width: 480
    height: 272
    color: "#666666"
    signal message(string msg)

    LineEdit {
        id: text_input1
        x: 208
        y: 129
        width: 82
        height: 26
        text: qsTr("")
        font.pointSize: 12
        radius: 2
    }

    Knob {
        id: knob1
        x: 52
        y: -20
        initialIndex: 0

        onKnobValueChanged: {
            text_input1.text = knob1.knobValue.toFixed(1).toString();
            if (! typeof connection === 'undefined')
                connection.sendMessage("txt.value=" + text_input1.text);
        }
    }

    Knob {
        id: knob2
        x: 56
        y: 112
        initialIndex: 0
        model: listModel3

        ListModel{
            id: listModel3
            ListElement{
                index: 0
                value: -3
            }
            ListElement{
                index: 1
                value: -2
            }
            ListElement{
                index: 2
                value: -1
            }
            ListElement{
                index: 3
                value: 0
            }
            ListElement{
                index: 4
                value: 1
            }
            ListElement{
                index: 5
                value: 2
            }
            ListElement{
                index: 6
                value: 3
            }
        }

        onKnobValueChanged: {
            text_input1.text = knob2.knobValue.toFixed(1).toString();
            if (! typeof connection === 'undefined')
                connection.sendMessage("txt.value=" + text_input1.text);
        }
    }

    GeometricKnob {
        id: dial1
        x: 244
        y: 118
        needleColor: "#084a95"
        outerCircleColor: "#aa9b38"
        innerCircleRadius: 73
        outerCircleRadius: 98

        model: listModel1

        ListModel{
            id: listModel1
            ListElement{
                index: 0
                value: -3
            }
            ListElement{
                index: 1
                value: -2
            }
            ListElement{
                index: 2
                value: -1
            }
            ListElement{
                index: 3
                value: 1
            }
            ListElement{
                index: 4
                value: 2
            }
            ListElement{
                index: 5
                value: 3
            }
        }

        onValueChanged: {
            text_input1.text = dial1.value.toFixed(1).toString();
            if (! typeof connection === 'undefined')
                connection.sendMessage("txt.value=" + text_input1.text);
        }
    }

    GeometricKnob {
        id: dial2
        x: 244
        y: -20
        model: listModel2

        ListModel{
            id: listModel2
            ListElement{
                index: 0
                value: 0
            }
            ListElement{
                index: 1
                value: 1
            }
            ListElement{
                index: 2
                value: 2
            }
            ListElement{
                index: 3
                value: 3
            }
            ListElement{
                index: 4
                value: 4
            }
            ListElement{
                index: 5
                value: 5
            }
            ListElement{
                index: 6
                value: 6
            }
            ListElement{
                index: 7
                value: 7
            }
            ListElement{
                index: 8
                value: 8
            }
            ListElement{
                index: 9
                value: 9
            }
            ListElement{
                index: 10
                value: 10
            }

        }

        onValueChanged: {
            text_input1.text = dial2.value.toFixed(1).toString();
            if (! typeof connection === 'undefined')
                connection.sendMessage("txt.value=" + text_input1.text);
        }
    }

    ImageButton{
        id:nextButton
        x: 415
        y: 150
        width: 48
        height: 48
        text: ""

        imageDown: "images/next_down.png"
        imageUp: "images/next_up.png"


        onButtonClick: {
            rootDial.message("dialdemo/largedemo.qml");
        }
    }

    ImageButton {
        id: quitButton
        x: 415
        y: 200
        width: 48
        height: 48
        text: ""
        imageDown: "images/quit_down.png"
        imageUp: "images/quit_up.png"
        onButtonClick: rootDial.message("../src/mainmenu.qml");
    }

}
