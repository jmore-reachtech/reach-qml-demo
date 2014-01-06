import QtQuick 1.1
import "components"
import "js/dataModel.js" as Db


Rectangle {
    width: 800
    height: 480
    id: root

    signal message(string msg)

    Image{
        source: "../images/bg.png"
        anchors.fill: parent
    }

    Text {
        id: textTitle
        x: 160
        y: 124
        width: 480
        color: "#ffffff"
        text: qsTr("Rinsing the coffee maker please wait...")
        font.underline: false
        font.pixelSize: 18
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        style: Text.Normal
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
    }

    ProgressBar{
        id: progress
        x: 210
        y: 208
        width: 381
        height: 23

    }

    Timer{
        id: timer

        interval: 100; running: true; repeat: true
        onTriggered: {
            progress.value += 2;
            if (progress.value == progress.maximum)
            {
                timer.stop();
                root.message("capacitive_coffeedemo/mainview.qml")
            }
        }
    }

    ImageButton {
        id: btnCancel
        x: 368
        y: 285
        width: 76
        height: 64
        text: ""
        imageUp: "images/btnCancel.png"
        imageDown: "images/btnCancelOff.png"
        onButtonClick: {
            if (typeof connection === "undefined")
                console.debug("rinse=0");
            else
                connection.sendMessage("rinse=0");
            root.message("capacitive_coffeedemo/mainview.qml");
        }
    }

    Component.onCompleted: {
        if (typeof connection === "undefined")
            console.debug("rinse=1");
        else
            connection.sendMessage("rinse=1");
    }


}
