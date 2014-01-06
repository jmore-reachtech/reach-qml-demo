import QtQuick 1.1

Item {
    id: checkList
    property alias model: listRepeater.model
    property alias values: valueModel
    property url imageChecked: "images/checkbox_click.bmp"
    property url imageUnChecked: "images/checkbox.bmp"
    property alias font: fontText.font
    property alias textColor: fontText.color
    property int spacing: 4
    property alias itemSpacing: col.spacing
    height: col.height
    width: 200

    Text {
        id: fontText
        font.family: "Arial"
        font.pixelSize: 16
        font.bold: false
        color: "White"
    }

    Column{
        id: col
        spacing: 10
        signal checked(string value)

        Repeater{
            id: listRepeater
            delegate:
                CheckButton{
                  id: id
                  text: item_text
                  value: item_value
                  imageChecked: checkList.imageChecked
                  imageUnchecked: checkList.imageUnChecked
                  font.family: fontText.font.family
                  font.pixelSize: fontText.font.pixelSize
                  font.bold: fontText.font.bold
                  textColor: fontText.color
                  checked: item_checked
                  height: item_height
                  width: item_width
                  spacing: checkList.spacing

                  onClicked:{
                      if (id.checked)
                      {
                          checkList.values.append({value: value});
                      }
                      else{
                          for(var i=0; i < checkList.values.count; i++)
                          {
                              if (checkList.values.get(i).value == value)
                                  break;
                          }
                          checkList.values.remove(i);

                      }
                  }

                  Component.onCompleted: {
                      if (id.checked)
                      {
                          checkList.values.append({value: value});
                      }

                  }

            }
        }

    }

    ListModel{
        id: data
        ListElement{item_value: "1"; item_text: "check 1"; item_height: 28; item_width: 28; item_checked: true;}
        ListElement{item_value: "2"; item_text: "check 2"; item_height: 28; item_width: 28; item_checked: false;}
    }

    ListModel{
        id: valueModel
    }

    Component.onCompleted: {

    }
}
