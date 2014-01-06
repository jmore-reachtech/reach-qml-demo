import QtQuick 1.0
import "components"

CheckBoxList {
    id: checkboxlist1
    imageChecked: "images/checkbox_click.png"
    imageUnChecked: "images/checkbox.png"
    textColor: "#000000"
    font.pixelSize: 16
    font.bold: false
    font.family: "Arial"
    spacing: 8
    itemSpacing: 10
    model: ListModel{
        ListElement{item_value: "1"; item_text: "check 1"; item_height: 28; item_width: 28; item_checked: true;}
        ListElement{item_value: "2"; item_text: "check 2"; item_height: 28; item_width: 28; item_checked: false;}
    }

}

