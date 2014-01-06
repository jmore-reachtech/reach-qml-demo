import QtQuick 1.0
import "../components"

CheckBoxList {
    id: checkboxlist1
    imageChecked: "images/checkbox_click.bmp"
    imageUnChecked: "images/checkbox.bmp"
    textColor: "#000000"
    font.pixelSize: 16
    font.bold: false
    font.family: "Arial"
    model: ListModel{
        ListElement{item_value: "1"; item_text: "check 1"}
        ListElement{item_value: "2"; item_text: "check 2"}
    }

}

