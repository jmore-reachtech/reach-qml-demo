import QtQuick 1.1

Rectangle{
    color: "#000000"
    width: 16
    height: parent.height
    property variant flickable
    property variant maxY : flickable.contentHeight
    property real step : 232/maxY
    radius: 4

    x: parent.width - width - 1

    Rectangle{
        id: handle
        color: "#CCCCCC"
        width: 16
        height: 40
        y: 0
        radius: 4

        MouseArea{
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.YAxis
            drag.minimumY: 0
            drag.maximumY: 232

            onPositionChanged: {
                flickable.contentY = handle.y * step;
            }
        }
    }

    Component.onCompleted: {}
}
