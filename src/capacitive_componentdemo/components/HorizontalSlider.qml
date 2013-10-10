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

        if (overlay.source)
            overlay.width = handle.x + handle.width/2;

        if (handle.x < slider.xMax - recValue.width)
            recValue.x = handle.x + handle.width;
        else
            recValue.x = handle.x - recValue.width;
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
    property alias imageOverlay: overlay.source
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
        source: "../images/slider_htrack.png"
    }

    BorderImage{
        id: overlay
        smooth: true;
        source: ""
        border { left: 10; top: 4; right: 2; bottom: 4 }
             horizontalTileMode: BorderImage.Stretch
             verticalTileMode: BorderImage.Stretch
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
                if (handle.x < slider.xMax - recValue.width)
                    recValue.x = handle.x + handle.width;
                else
                    recValue.x = handle.x - recValue.width;

            }
        }

    }

    Rectangle{
        id: recValue
        height: hintHeight
        radius: hintRadius
        border.width: hintBorderWidth
        border.color: hintBorderColor
        width: hintWidth
        visible: showHint && horizontalMouse.pressed
        anchors.verticalCenter:  parent.verticalCenter
        color: hintBackgroundColor

        Text {
            id: txtValue
            anchors.centerIn: parent
            text: slider.value.toFixed(1).toString();
            font.pixelSize: 14
            color: hintFontColor
        }

    }

    Component.onCompleted: {
        handle.x = (value - minimum) * ((slider.xMax - slider.xMin) / (maximum - minimum));

        if (overlay.source)
            overlay.width = handle.x + handle.width/2;
        handle.y = slider.handleY
        recValue.x = handle.x + recValue.width;
    }
}
