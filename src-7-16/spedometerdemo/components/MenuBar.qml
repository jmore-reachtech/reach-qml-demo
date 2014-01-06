import QtQuick 1.0

Item {
     id: menu
     //width: parent.width
     width: 582
     height: 60

     property int count: 0
     signal pressed(string source)

     ListModel {
         id: listModel

         ListElement {
             image: "../images/coffee-icon"; form: "/coffedemo/mainview.qml"; highlight: "content/images/menu/homehl.png"
         }
         ListElement {
             image: "../images/dial-icon"; form: "/dialdemo/mainviewlqml"; highlight: "content/images/menu/schedulehl.png"
         }
     }

     Component {
             id: listDelegate

                 Image{
                     id: itemBtn
                     property string val: image
                     property string hl: highlight
                     property string page: form
                     width: 66
                     height: 54
                     source: image
                     asynchronous: true

                     MouseArea{
                         id: mouseareaImage
                         anchors.fill: parent

                         onClicked: {
                             //console.debug(index);
                             view.currentIndex = index;
                             menu.pressed(page);
                         }

                         onEntered: {
                             itemBtn.source= hl;
                         }

                         onExited: {
                              itemBtn.source= val;
                         }

                         onCanceled: {
                             itemBtn.source= val;
                         }


                     }
                 }

         }


     Row{
         id: row
         spacing: 4
         height: parent.height
         width: parent.width

         Image{
             id: left
             source: "content/images/menu/spacer_button.png"
             height: 54
             width: 27

             MouseArea {
                 id: mouseareaLeft
                 anchors.fill: parent

                 onClicked: {
                     view.currentIndex = 0;
                     right.source = "content/images/menu/right_button.png";
                     left.source = "content/images/menu/spacer_button.png";
                     menu.pressed("");
                 }

             }

         }

         ListView {
             id: view
             width: 8 * 66
             height: 54
             model: listModel
             delegate: listDelegate
             orientation: ListView.Horizontal
             snapMode: ListView.SnapOneItem;
             flickDeceleration: 500
             highlightMoveDuration: 200
         }

         Image{
             id: right
             source: "content/images/menu/right_button.png"
             height: 54
             width: 27

             MouseArea {
                 id: mouseareaRight
                 anchors.fill: parent

                 onClicked: {
                     view.currentIndex = 10;
                     right.source = "content/images/menu/spacer_button.png";
                     left.source = "content/images/menu/left_button.png";
                     menu.pressed("");
                 }

             }
         }


     }


}
