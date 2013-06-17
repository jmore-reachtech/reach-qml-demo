import QtQuick 1.1

Item {
    id: root
    property string startPosition : "bottom"
    property int offset: 11
    property int increment: 9
    property int maxPixels: maxValue * increment
    property int minValue: 0
    property int maxValue: 18
    property int value: 0
    property alias imageOverlay: overlay.source
    property alias imageBase: base.source
    width: base.width
    height: base.height
    clip: true

    onValueChanged: {

        if (value > maxValue)
            value = maxValue;
        else if (value < minValue)
            value = minValue;

        if (startPosition == "top")
        {
            overlay.y = 0 + increment * (value - minValue);
        }
        else
        {
            overlay.y = 0 - increment * Math.abs(value - minValue);
        }
    }

    Image{
        id:base
        source: "../images/level.png"
    }

    Image{
       id: overlay
       source: "../images/level_overlay.png"
    }

    Component.onCompleted: {
        overlay.y = 0;
    }
}
