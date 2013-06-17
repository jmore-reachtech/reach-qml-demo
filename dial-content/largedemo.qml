import QtQuick 1.1
import "components"

Rectangle {
    id: rootDial
    width: 480
    height: 272
    color: "#666666"

    signal message(string msg)

    LineEdit {
        id: text_input1
        x: 199
        y: 13
        width: 82
        height: 26
        text: qsTr("")
        font.pixelSize: 18
        radius: 2
    }


    Knob {
        id: knob1
        anchors.centerIn: parent
        imageBase: "images/dialbase_large.svg"
        imageNeedle: "images/dialneedle_large.png"
        model: listModel3

        ListModel{
            id: listModel3
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
        }



        onValueChanged: {
            text_input1.text = knob1.value.toFixed(1).toString();
            connection.sendMessage("txt.value=" + text_input1.text);
        }
    }


    TextButton {
        id: textbutton1
        x: 352
        y: 15
        width: 101
        height: 24
        text: "Add Item"
        hoverTextColor: "#ffffff"
        buttonColor: "#32cd32"

        onButtonClick:{
            var i = listModel3.count;
            knob1.add = true;
            listModel3.append({"index": i, "value": i});
            text_input1.text = "";
        }
    }

    TextButton {
        id: textbutton2
        x: 352
        y: 46
        width: 101
        height: 24
        text: "Remove Item"
        hoverTextColor: "#ffffff"
        onButtonClick:{
            knob1.remove = true;
            var i = listModel3.count;
            listModel3.remove(i-1);
            text_input1.text = "";
        }
    }

    ImageButton {
        id: imagebutton1
        x: 405
        y: 200
        width:48
        height:48
        imageOff: "images/prev_down.png"
        imageOn: "images/prev_up.png"
        onButtonClick : rootDial.message("dials.qml");
    }


    ImageButton{
        id:nextButton
        x: 405
        y: 150
        width: 48
        height: 48

        imageOff: "images/next_down.png"
        imageOn: "images/next_up.png"


        onButtonClick: {
            rootDial.message("metronome.qml");
        }
    }


}

