import QtQuick 1.1

Item {
    id: switchGroup
    property string value;
    property url imageOn: "../images/internal_button_dn.bmp"
    property url imageOff: "../images/internal_button_up.bmp"
    property alias items: listRepeater.model
    property alias font: fontText.font
    property string textOnColor: "#000000"
    property string textOffColor: "#000000"

    onValueChanged: console.debug(value);

    Text {
        id: fontText
        font.family: "Arial"
        font.pixelSize: 16
        font.bold: false
        color: "Black"
    }

    ListModel{
        id: data
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

    Column{
        id: col
        spacing: 4
        signal checked(string value)
        onChecked :  {
            for (var i = 0; i < col.children.length; i++)
            {
                if (col.children[i].on != null)
                {
                    if (value == col.children[i].value)
                    {
                        switchGroup.value = value;
                    }
                else
                    {
                        col.children[i].on = false;
                    }
                }
            }
        }

        Repeater{
            id: listRepeater
            model: data
            delegate:
                Switch{
                  id: id
                  textOn: text_on
                  textOff: text_off
                  imageOn: image_on
                  imageOff: image_off
                  textOnColor: switchGroup.textOnColor
                  textOffColor: switchGroup.textOffColor
                  textOnFontFamily: fontText.font.family
                  textOffFontFamily: fontText.font.family
                  textOffBold: fontText.font.bold
                  textOnBold: fontText.font.bold
                  textOnFontSize: fontText.font.pixelSize
                  textOffFontSize: fontText.font.pixelSize
                  value: val
                  width: 60
                  height: 40
                  on: false
                  onButtonClick:
                      if (id.on)
                          col.checked(value);
                      else
                          switchGroup.value = "";
            }
        }

    }


}

