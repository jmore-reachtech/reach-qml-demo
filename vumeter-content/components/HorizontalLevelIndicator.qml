import QtQuick 1.1

Item {
    id: root
    property string startPosition : "left"
    property int offset: 0
    property int increment: 4
    property int maxPixels: maxValue * increment
    property int minValue: 0
    property int maxValue: 50
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

        if (startPosition == "right")
        {
            overlay.x = base.width - increment * Math.abs(value - minValue);
        }
        else
        {
            overlay.x = 0 - base.width + increment * Math.abs(value - minValue);
        }
    }

    Image{
        id:base
        source: "../images/tank.png"
    }

    Image{
       id: overlay
       source: "../images/tank_overlay.png"
    }


    Component.onCompleted: {
        if (startPosition == "right")
            overlay.x = base.width;
        else
            overlay.x = 0 - base.width;

    }
}
