import QtQuick 1.0

 Rectangle {
     width: 480; height: 272
     id: item1
     color: "#666666"

     Row{
         id: row1
         spacing: 8
         anchors.centerIn: parent;
         signal buttonPressed(string folder);
         onButtonPressed: {
             connection.sendMessage("txtFolder.text=" + folder);
             launcher.launchScript(folder);
         }
     }

     ScriptLauncher{
         id: launcher
     }


     Component.onCompleted: {
         var list = launcher.getContent();

         for (var i = 0; i < list.length; i++)
         {
             var data = list[i].split("||");
             var object = Qt.createQmlObject('ImageButton { imageOn: "' + data[1] + '"; text: "' + data[2] + '"; row: "row1"; imageOff: "' + data[1] + '"; folderLocation: "' + data[0] + '";}', row1);

         }
     }


 }
