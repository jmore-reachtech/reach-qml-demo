import QtQuick 1.0
import "components"

Rectangle {
    width: 800
    height: 480
    id: root
    objectName: "root"
    signal message(string msg)

    Image{
        source: "images/bg_dark.png"
        anchors.fill: parent
    }

    ListModel {
        id: listModel

        ListElement {
            image: "images/coffee-icon.png"; iconheight:76; iconwidth: 100; form: "capacitive_coffeedemo/mainview.qml"; icontext: "  Capacitive\nCoffee Demo"
        }
        ListElement {
            image: "images/coffee-icon.png"; iconheight:76; iconwidth: 100; form: "resistive_coffeedemo/mainview.qml"; icontext: "   Resistive\nCoffee Demo"
        }
        ListElement {
            image: "images/dial-icon.png"; iconheight:76; iconwidth: 76; form: "dialdemo/mainview.qml"; icontext: "Dial Demo"
        }
        ListElement {
            image: "images/vumeter-icon.png"; iconheight:74; iconwidth: 110; form: "vumeterdemo/mainview.qml"; icontext: "VU Meter Demo"
        }
        ListElement {
            image: "images/samegame-icon.png"; iconheight:74; iconwidth: 110; form: "samegame/mainview.qml"; icontext: "Same Game"
        }
        ListElement {
            image: "images/spedometer-icon.png"; iconheight:78; iconwidth: 78; form: "spedometerdemo/mainview.qml"; icontext: "Spedometer Demo"
        }
        ListElement {
            image: "images/reach-icon.png"; iconheight:76; iconwidth: 76; form: "capacitive_componentdemo/mainview.qml"; icontext: "     Capacitive\nComponent Demo"
        }
        ListElement {
            image: "images/reach-icon.png"; iconheight:76; iconwidth: 76; form: "resistive_componentdemo/mainview.qml"; icontext: "      Resistive\nComponent Demo"
        }
        ListElement {
                    image: "images/graph-icon.png"; iconheight:64; iconwidth: 76; form: "graphdemo/mainview.qml"; icontext: "Graph Demo"
        }
    }

    GridView{
        id: menu
        x: 0
        y: 0
        property int rows: Math.ceil(menu.count/4)
        property int page: 1
        model: listModel
        currentIndex: -1 // default - no focus
        width: 800
        height: parent.height
        delegate: appDelegate
        cellWidth: 400; cellHeight: 240
        clip: true
        focus: true

        onFlickEnded: {
            if (menu.atYBeginning)
                page = 1;
            else if (menu.atYEnd)
                page = rows;
        }
    }

    Component {
        id: appDelegate

        Item {
            width: 400; height: 240 // controls the size
            Rectangle
            {
                id: recIcon
                width: 136
                height: 112
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: index % 2 == 0 ? 40: -40
                color: "transparent"
                Image {
                    id: imgIcon
                    width: iconwidth; height: iconheight
                    source: image
                    smooth: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top : parent.top
                    anchors.topMargin: 6
                }
                Text {
                    id: textIcon
                    anchors { // draw this below and centre to the image
                        top: imgIcon.bottom;
                        horizontalCenter: imgIcon.horizontalCenter;
                        topMargin: 4;
                    }
                    text: icontext
                    font.pixelSize: 16
                    color:"white"
                    smooth: true
                }

                MouseArea{
                    anchors.fill: parent

                    onPressed: {
                        textIcon.color = "yellow";
                        imgIcon.opacity = 0.7;
                        textIcon.opacity = 0.7;
                        timer1.start();
                    }

                    onReleased: {
                        textIcon.color = "yellow";
                        imgIcon.opacity = 0.7;
                        textIcon.opacity = 0.7;
                    }

                    onCanceled: {
                        timer1.stop();
                        textIcon.color = "white";
                        imgIcon.opacity = 1.0;
                        textIcon.opacity = 1.0;
                    }
                }

                Timer{
                    id: timer1
                    interval: 200;
                    running: false;
                    repeat: false
                    onTriggered: root.message(form);
                }

            }
        }
    }

    BorderImage {
        id: border_image1
        x: 0
        y: 157
        width: 50
        height: 48
        source: "images/uparrow.png"
    }

    BorderImage {
        id: border_image2
        x: 1
        y: 275
        width: 50
        height: 48
        source: "images/down_arrow.png"
    }

    Text {
        id: text1
        x: 2
        y: 231
        color: "#ffffff"
        text: qsTr("Swipe")
        rotation: -90
        font.pixelSize: 16
    }

    ImageButton {
        id: image_button1
        x: 735
        y: 420
        width: 40
        height: 40
        text: ""
        imageUp: "images/down-arrow_up.png"
        font.pixelSize: 18
        textColor: "#000000"
        imageDown: "images/down-arrow_down.png"
        font.bold: false
        font.family: "Arial"

        onButtonClick: {
            var index = 0;
            menu.page += 1;
            if (menu.page > menu.rows)
                menu.page = menu.rows;

            index = (menu.page - 1) * 4;
            menu.positionViewAtIndex(index, GridView.Beginning);
        }
    }

    ImageButton {
        id: image_button2
        x: 735
        y: 21
        width: 40
        height: 40
        text: ""
        imageUp: "images/up-arrow_up.png"
        font.pixelSize: 18
        textColor: "#000000"
        imageDown: "images/up-arrow_down.png"
        font.bold: false
        font.family: "Arial"

        onButtonClick: {
            var index = 0;
            menu.page -= 1;
            if (menu.page < 1)
                menu.page = 1;
            index = (menu.page - 1) * 4;
            menu.positionViewAtIndex(index, GridView.Beginning);
        }
    }

}
