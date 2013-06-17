import QtQuick 1.0

Item {
    id: slider;
    width: 48;
    height: 184
    // value is read/write.
    property int value: 0
    onValueChanged: {
        if (value < minimum)
            value = minimum;
        if (value > maximum)
            value = maximum;

        handle.y = slider.yMax - ((value - minimum)*slider.yMax/(maximum-minimum))
        console.debug(value);
    }

    property bool allowDrag: true
    onAllowDragChanged: {
        if (!allowDrag)
        {
            verticalMouse.enabled = false;
        }
    }

    property real maximum: 10
    property real minimum: 0
    property int handleX: 0
    property int yMin: 2
    property int yMax: sliderTrack.height - handle.height
    property alias imageTrack: sliderTrack.source
    property alias imageHandle: handle.source

    Image{
        id: sliderTrack
        source: "../images/slider_track.bmp"
        anchors.fill: parent
    }

    Image {
        id: handle
        smooth: true
        x: handleX
        source: "../images/slider_handle.png"


        MouseArea {
            id: verticalMouse
            anchors.fill: parent; drag.target: parent
            drag.axis: Drag.YAxis; drag.minimumY: slider.yMin; drag.maximumY: slider.yMax
            onPositionChanged: {
                value = (maximum - minimum) * (slider.yMax - handle.y-2) / slider.yMax + minimum;
                recValue.x = handle.x+4;
                if (handle.y < slider.yMax - 40)
                    recValue.y = handle.y + 46;
                else
                    recValue.y = handle.y - 40;
            }
        }
    }

    Rectangle{
        id: recValue
        height: 40
        radius: 9
        border.width: 2
        border.color: "#000000"
        width: 40
        visible: verticalMouse.pressed

        Text {
            id: txtValue
            anchors.centerIn: parent
            text: slider.value.toFixed(1).toString();
            font.pixelSize: 14
        }

    }

    Component.onCompleted: {
        handle.y = slider.yMax - ((value - minimum)*slider.yMax/(maximum-minimum));
        recValue.y = handle.y - 40;
    }
}
