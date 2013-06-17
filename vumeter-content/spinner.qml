import QtQuick 1.1
import "components"

Rectangle {
    id: root
    width: 480
    height: 272
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

    Spinner{
        x: 103
        y: 28
        width: 83
        height: 216

        model :
            ListModel{
                id: data
                ListElement{ index: 1; value: 0}
                ListElement{ index: 2; value: 1}
                ListElement{ index: 3; value: 2}
                ListElement{ index: 4; value: 3}
                ListElement{ index: 5; value: 4}
                ListElement{ index: 6; value: 5}
                ListElement{ index: 7; value: 6}
                ListElement{ index: 8; value: 7}
                ListElement{ index: 9; value: 8}
                ListElement{ index: 10; value: 9}
                ListElement{ index: 11; value: 10}
            }

            onValueChanged: li.value = value;
    }

    HorizontalLevelIndicator{
        id: li
        x: 237
        y: 126
        increment: 20
        maxPixels: 200
        maxValue: 14


    }


    MouseArea {
        id: mousearea1
        x: 277
        y: 5
        width: 100
        height: 100

        onPressed: root.message("vumeter.qml");
    }
    
}
