import QtQuick 1.1
import "components"

VerticalSwitchGroup {
    id: verticalswitchgroup1
    spacing: 4
    font.pixelSize: 16
    font.bold: false
    font.family: "Arial"
    textOffColor: "#000000"
    textOnColor: "#000000"
    model: ListModel{
        ListElement{
            val: "1";
            text_on: "On 1";
            text_off: "Off 1";
            image_on: "../images/internal_button_dn.bmp";
            image_off: "../images/internal_button_up.bmp"
        }
        ListElement{
            val: "2";
            text_on: "On 2";
            text_off: "Off 2";
            image_on: "../images/internal_button_dn.bmp";
            image_off: "../images/internal_button_up.bmp"
        }
    }

}
