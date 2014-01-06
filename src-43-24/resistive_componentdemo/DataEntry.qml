import QtQuick 1.1
import "components"

Rectangle {
    id: root
    objectName: "root"
    width: 480
    height: 272
    color: "#666666"
    signal message(string msg)

    gradient: Gradient {
        GradientStop {position: 0.0; color: "#666666"}
        GradientStop {position: 1.0; color: "#EEEEEE"}
    }

    Text {
        id: txtTitle
        x: 0
        y: 8
        width: 480
        height: 25
        text: qsTr("Data Entry")
        horizontalAlignment: Text.AlignHCenter
        font.bold: false
        font.pixelSize: 21
    }

    AlphaField {
        id: tbName
        x: 78
        y: 51
        width: 302
        height: 34
        labelFontBold: false
        keyboardBackGroundImage: "images/keyboardbg.png"
        normalKeyIcon: "images/key1_off.png"
        pressedKeyIcon: "images/key1_on.png"
        normalSpaceKeyIcon: "images/keyspacer1_off.png"
        pressedSpaceKeyIcon: "images/keyspacer1_on.png"
        normalBackKeyIcon: "images/keyback1_off.png"
        pressedBackKeyIcon: "images/keyback1_on.png"
        fieldSpacing: 7
        inputText: ""
        keyTextColor: "#000000"
        keyTextBold: true
        keyTextFontSize: 14
        inputColor: "#ffffff"
        labelColor: "#000000"
        inputFontPixelSize: 14
        keyboardAnimationSpeed: 100
        inputFontFamily: "Arial"
        labelFontFamily: "Arial"
        labelFontPixelSize: 14
        labelText: "Name"
        z: 30
    }

    NumericField {
        id: numeric_field1
        x: 78
        y: 91
        width: 180
        normalKeyIcon: "images/key1_off.png"
        pressedKeyIcon: "images/key1_on.png"
        max: 100
        fieldSpacing: 18
        min: 0
        inputText: ""
        keyTextColor: "#000000"
        keyTextBold: true
        keyTextFontSize: 14
        keyWidth: 40
        keyHeight: 40
        inputColor: "#ffffff"
        labelColor: "#000000"
        inputFontPixelSize: 14
        keyboardAnimationSpeed: 100
        inputFontFamily: "Arial"
        labelFontFamily: "Arial"
        labelFontPixelSize: 14
        labelText: "Age"
    }

    RadioButtonList {
        id: radiobutton_list2
        x: 78
        y: 167
        spacing: 4
        itemSpacing: 4
        font.pixelSize: 14
        textColor: "#000000"
        font.family: "Arial"
        font.bold: false
        model: ListModel {
            ListElement {
                item_value: "1"
                item_checked: true
                item_height: 26
                item_width: 26
                item_text: "PDWZ100"
            }

            ListElement {
                item_value: "2"
                item_checked: false
                item_height: 26
                item_width: 26
                item_text: "PDWZ200"
            }
        }
        imageUnChecked: "images/radiobutton.png"
        imageChecked: "images/radiobutton_click.png"
    }

    Text {
        id: text1
        x: 76
        y: 140
        text: qsTr("Product Code")
        font.pixelSize: 14
    }

    Text {
        id: text2
        x: 244
        y: 140
        text: qsTr("Where did you buy this product?")
        font.pixelSize: 14
    }

    CheckBoxList {
        id: checkbox_list1
        x: 244
        y: 167
        spacing: 8
        itemSpacing: 5
        font.pixelSize: 16
        textColor: "#000000"
        font.family: "Arial"
        font.bold: false
        model: ListModel {
            ListElement {
                item_value: "1"
                item_checked: true
                item_height: 24
                item_width: 24
                item_text: "Store 1"
            }

            ListElement {
                item_value: "2"
                item_checked: false
                item_height: 24
                item_width: 24
                item_text: "Store 2"
            }
            ListElement {
                item_value: "3"
                item_checked: false
                item_height: 24
                item_width: 24
                item_text: "Store 3"
            }
        }
        imageUnChecked: "images/checkbox.png"
        imageChecked: "images/checkbox_click.png"
    }


}
