import QtQuick 1.1
import "../content/components"
import "../content/js/dataModel.js" as Db


Rectangle {
    width: 480
    height: 272
    id: root
    color: "#2D2D2D"

    signal message(string msg)

    gradient: Gradient {
        GradientStop {position: 0.0; color: "#2D2D2D"}
        GradientStop {position: 1.0; color: "#666666"}
    }

    Text {
        id: textTitle
        x: 0
        y: 41
        width: 480
        color: "#ffffff"
        text: qsTr("Rinsing the coffee maker please wait...")
        font.underline: false
        font.pointSize: 16
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        style: Text.Normal
        font.bold: true
        font.family: "MV Boli"
        horizontalAlignment: Text.AlignHCenter
    }

    ProgressBar{
        id: progress
        x: 50
        y: 125
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
                root.message("visible")
            }
        }
    }

    ImageButton {
        id: btnCancel
        x: 208
        y: 202
        width: 66
        height: 56
        imageOn: "images/btnCancel.png"
        imageOff: "images/btnCancelOff.png"
        onButtonClick: {
            root.message("visible")
            connection.sendMessage("rinse=0")
        }
    }

    Component.onCompleted: {
        connection.sendMessage("rinse=1")
    }


}
