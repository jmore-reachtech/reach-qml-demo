import QtQuick 1.0

 Item {
     width: 480; height: 272
     id: item1

     Row{
         id: row1
         spacing: 6
         anchors.centerIn: parent;
         signal buttonPressed(string folder);
         onButtonPressed: console.debug(folder);

     }

     ScriptLauncher{
         id: launcher
     }


     Component.onCompleted: {
         var list = launcher.getContent();

         for (var i = 0; i < list.length; i++)
         {
             var data = list[i].split("||");
             var object = Qt.createQmlObject('ImageButton {imageOn: "' + data[1] + '"; text: "' + data[2] + '"; row: "row1"; imageOff: "' + data[1] + '"; folderLocation: "' + data[0] + '";}', row1);

         }
     }


 }
