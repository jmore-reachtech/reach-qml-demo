import QtQuick 1.1

Rectangle
{
    property alias model: view.model
    property alias currentIndex: view.currentIndex
    property int initialIndex: 0
    property int value: view.model.get(currentIndex).value
    property int itemHeight: 29
    property alias backGroundImage: bgImage.source
    property color textColor: "black"
    property alias highlightImage: hlImage.source
    property alias font: fontText.font
    property int viewCount: 7

    color: "White"
    height: 216
    width: 100
    border.color: "black"
    radius: 2
    border.width: 3
    clip: true

    ListModel{
        id: data
        ListElement{ index: 1; value: 1}
        ListElement{ index: 2; value: 2}
        ListElement{ index: 3; value: 3}
        ListElement{ index: 4; value: 4}
        ListElement{ index: 5; value: 5}
        ListElement{ index: 6; value: 6}
    }

    Text {
        id: fontText
        font.family: "Arial"
        font.pixelSize: 18
        font.bold: false
    }

    Image {
        id: bgImage
        source: "../images/spinner-bg.png"
        width: parent.width
        height: parent.height
    }

    Image {
        id : hlImage
        source: "../images/spinner-select.png"
        visible: false
    }

    PathView {
        id: view
        anchors.fill: parent
        currentIndex: 0
        pathItemCount: view.height/itemHeight
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlight: Image {source: hlImage.source; width: view.width; height: itemHeight+4 }
        dragMargin: view.width/2

        path: Path {
            startX: view.width/2; startY: -itemHeight/2
            PathLine { x: view.width/2; y: view.pathItemCount*itemHeight + itemHeight }
        }

        delegate: spinnerDelegate
    }

    Component{
        id: spinnerDelegate
        Rectangle{
            color: "transparent"
            height: itemHeight

            Text {
                anchors.centerIn: parent;
                color: textColor;
                font.bold: fontText.font.bold;
                font.family: fontText.font.family;
                font.pixelSize: fontText.font.pixelSize;
                text: index;
                smooth:true
            }
        }
    }

    Keys.onDownPressed: view.incrementCurrentIndex()
    Keys.onUpPressed: view.decrementCurrentIndex()

    onInitialIndexChanged: {
        view.currentIndex = initialIndex;
    }

    Component.onCompleted:  view.currentIndex = initialIndex;
}
