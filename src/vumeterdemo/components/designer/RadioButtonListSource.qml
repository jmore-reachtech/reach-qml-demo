import QtQuick 1.0
import "components"

RadioButtonList {
    id: radiobutton_list1
    textColor: "#000000"
    font.pixelSize: 16
    font.bold: false
    font.family: "Arial"
    imageChecked: "images/radiobutton_click.png"
    imageUnChecked: "images/radiobutton.png"
    model: ListModel{
        ListElement{item_value: "1"; item_text: "radio 1"}
        ListElement{item_value: "2"; item_text: "radio 2"}
    }
}
