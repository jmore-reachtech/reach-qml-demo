import QtQuick 1.1

Item {
    id: switchGroup
    property string value;
    property alias model: listRepeater.model
    property alias font: fontText.font
    property string textOnColor: "#000000"
    property string textOffColor: "#000000"
    property alias spacing: col.spacing

    width: col.width
    height: col.height

    Text {
        id: fontText
        font.family: "Arial"
        font.pixelSize: 16
        font.bold: false
        color: "Black"
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
                width: item_width
                height: item_height
                  onButtonClick:
                      if (id.on)
                          col.checked(value);
                      else
                          switchGroup.value = "";
            }
        }

    }


}

