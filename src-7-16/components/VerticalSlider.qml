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
        handle.y = (maximum - value) * increment;
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
    property int yPressed
    property int increment: (yMax - yMin)/(maximum - minimum)
    property alias imageTrack: sliderTrack.source
    property alias imageHandle: handle.source
    property bool showHint: true
    property alias hintFontFamily: txtValue.font.family
    property alias hintFontPixelSize: txtValue.font.pixelSize
    property alias hintFontPointSize: txtValue.font.pointSize
    property alias hintFontBold: txtValue.font.bold
    property alias hintFontItalic: txtValue.font.italic
    property alias hintFontUnderline: txtValue.font.underline
    property alias hintFontStrikeout: txtValue.font.strikeout
    property int hintWidth: 40
    property int hintHeight: 40
    property color hintBackgroundColor: "#ffffff"
    property int hintRadius: 9
    property color hintBorderColor: "#000000"
    property int hintBorderWidth: 2
    property color hintFontColor: "#000000"

    Image{
        id: sliderTrack
        source: "../images/slider_track.bmp"
        anchors.fill: parent
    }

    Rectangle{
        id: recValue
        height: hintHeight
        radius: hintRadius
        border.width: hintBorderWidth
        border.color: hintBorderColor
        width: hintWidth
        visible: showHint && verticalMouse.pressed
        anchors.horizontalCenter:  parent.horizontalCenter
        color: hintBackgroundColor
        Text {
            id: txtValue
            anchors.centerIn: parent
            text: slider.value.toFixed(1).toString();
            font.pixelSize: 14
            color: hintFontColor
        }

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
                value = -handle.y/increment + maximum;

                if (handle.y < handle.height/2)
                {
                    //Set to bottom of handle
                    recValue.y = handle.y + handle.height;
                }
                else
                {
                    //Set to top of handle
                    recValue.y = handle.y - recValue.height;
                }


            }
        }
    }


    Component.onCompleted: {
        handle.y = (maximum - value) * increment;
        handle.x = slider.handleX
        recValue.y = handle.y - recValue.height;
        yPressed = yMax;
    }
}
