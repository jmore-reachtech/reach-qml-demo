import QtQuick 1.1

Rectangle {
    width: 640
    height: 360
    color: "black"
    property ListModel items: ListModel {}
    property int currentIndex: view.currentIndex

    PathView {
        id: view
        width: parent.width
        height: parent.height + y
        y: -33
        model: items
        delegate: delegate
        path: p
    }

    Component {
        id: delegate
        Column {
            id: wrapper
            scale: 4. * y / view.height
            z: y
            opacity: scale / 1.2

            Image {
                anchors.horizontalCenter: delegateText.horizontalCenter
                width: 64; height: 64
                smooth: true
                source: iconSource
            }

            Text {
                id: delegateText
                text: listText
                font.pointSize: 12
                font.family: "MV Boli"
                smooth: true
                color: wrapper.PathView.isCurrentItem ? "white" : "black"
            }

        }
    }


    Path {
        id: p
        property real width: view.width
        property real height: view.height
        property real margin: 50
        property real cx: width / 2
        property real cy: height / 2
        property real rx: width / 2 - margin
        property real ry: height / 2 - margin
        property real mx: rx * magic
        property real my: ry * magic
        property real magic: 0.551784
        startX: p.cx; startY: p.cy + p.ry
        PathCubic { // second quadrant arc
            control1X: p.cx - p.mx; control1Y: p.cy + p.ry
            control2X: p.cx - p.rx; control2Y: p.cy + p.my
            x: p.cx - p.rx; y: p.cy
        }
        PathCubic { // third quadrant arc
            control1X: p.cx - p.rx; control1Y: p.cy - p.my
            control2X: p.cx - p.mx; control2Y: p.cy - p.ry
            x: p.cx; y: p.cy - p.ry
        }
        PathCubic { // forth quadrant arc
            control1X: p.cx + p.mx; control1Y: p.cy - p.ry
            control2X: p.cx + p.rx; control2Y: p.cy - p.my
            x: p.cx + p.rx; y: p.cy
        }
        PathCubic { // first quadrant arc
            control1X: p.cx + p.rx; control1Y: p.cy + p.my
            control2X: p.cx + p.mx; control2Y: p.cy + p.ry
            x: p.cx; y: p.cy + p.ry
        }
    }


 }
