import QtQuick 1.1

Item {
    id: checkList
    property alias items: listRepeater.model
    property alias values: valueModel
    property url imageChecked: "images/checkbox_checked.svg"
    property url imageUnChecked: "images/checkbox_unchecked.svg"
    property alias font: fontText.font
    property alias textColor: fontText.color


    ListModel{
        id: data
        ListElement{item_value: "1"; item_text: "check 1"}
        ListElement{item_value: "2"; item_text: "check 2"}
    }

    ListModel{
        id: valueModel
    }

    Text {
        id: fontText
        font.family: "Arial"
        font.pixelSize: 16
        font.bold: false
        color: "White"
    }

    Column{
        id: col
        spacing: 14
        signal checked(string value)

        Repeater{
            id: listRepeater
            model: data
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

            }
        }

    }

    Component.onCompleted: {

    }
}
