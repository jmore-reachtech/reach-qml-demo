import QtQuick 1.1
import "../components"
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
        x: 154
        y: 118
        width: 480
        color: "#ffffff"
        text: qsTr("Placeholder for Setting Controls")
        font.underline: false
        font.pointSize: 16
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        style: Text.Normal
        font.bold: true
        font.family: "MV Boli"
        horizontalAlignment: Text.AlignHCenter
    }


    ImageButton {
        id: btnCancel
        x: 362
        y: 279
        width: 76
        height: 64
        text: ""
        imageUp: "images/btnCancel.png"
        imageDown: "images/btnCancelOff.png"
        onButtonClick: {
            root.message("capacitive_coffeedemo/mainview.qml")
        }
    }
}
