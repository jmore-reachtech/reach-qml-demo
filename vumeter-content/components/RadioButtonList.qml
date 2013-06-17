import QtQuick 1.1

Item {
    id: radioList
    property string value;
    property alias items: listRepeater.model
    property url imageChecked: "../images/radio_checked.svg"
    property url imageUnChecked: "../images/radio_unchecked.svg"
    property alias font: fontText.font
    property alias textColor: fontText.color
    onValueChanged: console.debug(value);

    ListModel{
        id: data
        ListElement{item_value: "1"; item_text: "radio 1"}
        ListElement{item_value: "2"; item_text: "radio 2"}
    }

    Text {
        id: fontText
        font.family: "Arial"
        font.pixelSize: 14
        font.bold: false
        color: "White"
    }

    Column{
        id: col
        spacing: 10
        signal checked(string value)
        onChecked :  {
            for (var i = 0; i < col.children.length; i++)
            {
                if (col.children[i].checked != null)
                {
                    if (value == col.children[i].value)
                    {
                        radioList.value = value;
                    }
                else
                    {
                        col.children[i].checked = false;
                    }
                }
            }
        }

        Repeater{
            id: listRepeater
            objectName: "repeater"
            model: data
            delegate:
                CheckButton{
                  id: id
                  text: item_text
                  value: item_value
                  imageChecked: radioList.imageChecked
                  imageUnchecked: radioList.imageUnChecked
                  font.family: fontText.font.family
                  font.pixelSize: fontText.font.pixelSize
                  font.bold: fontText.font.bold
                  textColor: fontText.color

                  onClicked: if (id.checked)
                               col.checked(value);
                           else
                               radioList.value = "";
            }
        }

    }


}
