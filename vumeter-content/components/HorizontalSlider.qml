import QtQuick 1.0

Item {
    id: slider;
    width: 184
    height: 48
    // value is read/write.
    property int value: 0
    onValueChanged: {
        if (value < minimum)
            value = minimum;
        if (value > maximum)
            value = maximum;
        handle.x = (value - minimum) * ((slider.xMax - slider.xMin) / (maximum - minimum));
    }

    property bool allowDrag: true
    onAllowDragChanged: {
        if (!allowDrag)
            horizontalMouse.enabled = false;
    }

    property real maximum: 10
    property real minimum: 0
    property int xMax: sliderTrack.width - handle.width
    property int xMin: 0
    property int handleY: 2
    property alias imageTrack: sliderTrack.source
    property alias imageHandle: handle.source

    Image{
        id: sliderTrack
        source: "../images/slider_htrack.png"
        anchors.fill: parent
    }

    Image {
        id: handle;
        smooth: true
        y: handleY;
        source: "../images/slider_handle.png"

        MouseArea {
            id: horizontalMouse
            anchors.fill: parent; drag.target: parent
            drag.axis: Drag.XAxis; drag.minimumX: slider.xMin; drag.maximumX: slider.xMax
            onPositionChanged: {
                value = handle.x / ((slider.xMax - slider.xMin) / (maximum - minimum)) + minimum
                console.debug(value);
            }
        }

    }


    Component.onCompleted: {
            handle.x = (value - minimum) * ((slider.xMax - slider.xMin) / (maximum - minimum));
            handle.y = slider.handleY
    }
}

