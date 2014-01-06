import QtQuick 1.1

Item{
    id: control
    property alias imagePanel: imgPanel.source
    property alias text: txtReadOut.text
    property alias textColor: txtReadOut.color
    property alias font: txtReadOut.font

    BorderImage {
        id: imgPanel
        anchors.fill: parent
        source: "../images/bezel.bmp"

        Text{
            id: txtReadOut
            text: "100000"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: "DejaVu Sans"
            font.pixelSize: 12
            color: "#50dd0e"
        }

    }
}
