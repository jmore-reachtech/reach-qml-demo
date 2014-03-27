import QtQuick 1.1

Item {
    id: radioList
    property string value;
    property int childID;
    property alias model: listRepeater.model
    property url imageChecked: "../images/radiobutton_click.png"
    property url imageUnChecked: "../images/radiobutton.png"
    property int imageHeight: 32
    property int imageWidth: 32
    property alias font: fontText.font
    property alias textColor: fontText.color
    property int spacing: 4
    property alias itemSpacing: col.spacing
    width: col.width
    height: col.height

    ListModel{
        id: data
        ListElement{item_value: "1"; item_text: "radio 1"; item_height: 26; item_width: 26; item_checked: true}
        ListElement{item_value: "2"; item_text: "radio 2"; item_height: 26; item_width: 26; item_checked: false}
    }

    Text {
        id: fontText
        font.family: "DejaVu Sans"
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
                  imageHeight: radioList.imageHeight
                  imageWidth: radioList.imageWidth
                  checked: item_checked
                  spacing: radioList.spacing

                  onClicked: if (id.checked)
                               col.checked(value);
                             else if (radioList.value === value)
                                 id.checked = true;


                  Component.onCompleted: {
                      if (id.checked)
                      {
                          col.checked(value);
                          radioList.value = value;
                      }
                  }
            }
        }

    }


}
