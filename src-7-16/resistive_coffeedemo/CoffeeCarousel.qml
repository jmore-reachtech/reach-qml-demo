import QtQuick 1.1

Rectangle {
    width: 480
    height: 180
    color: "transparent"
    property ListModel items: ListModel {}
    property int currentIndex: view.currentIndex
    // sets the number of pixels between press and release
    // lessthan this it is a touch, more than this it is a swipe
    property int mouseXdist: 10
    property int x_pos

    PathView {
        id: view
        width: parent.width
        height: parent.height + y
        y: -33
        model: items
        delegate: delegate
        path: p
        interactive: false
        MouseArea {
             anchors.fill: parent
             onPressed: {
                 x_pos = mouse.x
             }

             onReleased: {
                 // if its just a press and release at the same approx location
                 // then use that location to inc or dec
                 if ( ( (mouse.x >= x_pos) && ((mouse.x - x_pos) < mouseXdist) ) ||
                      ( (mouse.x < x_pos) && ((x_pos - mouse.x) < mouseXdist) ) )  {

                     if (mouse.x > parent.width/2) {
                        view.decrementCurrentIndex()
                    }
                    else {
                        view.incrementCurrentIndex()
                    }
                 }
                 else {
                     if( mouse.x > x_pos ) {
                        view.incrementCurrentIndex()
                     }
                     else {
                         view.decrementCurrentIndex()
                     }
                 }

             }
         }
    }

    function setCurrentIndex(val)
    {
        view.currentIndex = val;
    }

    Component {
        id: delegate

            Image {
                id: wrapper
                //anchors.horizontalCenter: delegateText.horizontalCenter
                width: 200; height:119
                source: "../capacitive_coffeedemo/images/coffee_cup_small.png"
                scale: 4. * y / view.height * 6. / items.count
                z: y
                opacity: scale / 1.3
                asynchronous: true

                Text {
                    id: delegateText
                    text: recipeName
                    width: 110
                    wrapMode: Text.Wrap
                    font.pixelSize: 18
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenterOffset: -18
                    anchors.verticalCenterOffset: -16
                    color: wrapper.PathView.isCurrentItem ? "white" : "black"

                }

                Component.onCompleted: {
                    //console.debug(listText + ": " + scale)
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

