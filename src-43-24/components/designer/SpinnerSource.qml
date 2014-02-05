import QtQuick 1.1
import "components"

Spinner {
    id: spinner1
    width: 90
    height: 216
    color: "#ffffff"
    radius: 2
    font.pixelSize: 24
    textColor: "#000000"
    initialIndex: 0
    border.color: "#000000"
    border.width: 3
    backGroundImage: "images/spinner-bg.png"
    font.family: "Arial"
    font.bold: false
    highlightImage: "images/spinner-select.png"
    itemHeight: 34

    model:  ListModel{
        ListElement{ index: 1; value: 1}
        ListElement{ index: 2; value: 2}
        ListElement{ index: 3; value: 3}
        ListElement{ index: 4; value: 4}
        ListElement{ index: 5; value: 5}
        ListElement{ index: 6; value: 6}
        ListElement{ index: 7; value: 7}
        ListElement{ index: 8; value: 8}
        ListElement{ index: 9; value: 9}
        ListElement{ index: 10; value: 10}
    }
}
