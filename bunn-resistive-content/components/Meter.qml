import QtQuick 1.1

Item {
    id: root
    width: 210
    height: 210
    property real value : 0
    property real maxAngle:  133
    property real minAngle: -130
    property real minValue:  0
    property real maxValue:  120
    property alias angle: needleRotation.angle
    property alias backGroundImage: background.source
    property alias needleImage:  needle.source
    property alias needleImageWidth: needle.width
    property alias needleImageHeight:  needle.height
    property alias needleX: needle.x
    property alias needleY: needle.y
    property alias needleRotationOriginX: needleRotation.origin.x
    property alias needleRotationOriginY: needleRotation.origin.y
    property alias overlayImage: overlay.source
    property alias overlayImageWidth:  overlay.width
    property alias overlayImageHeight:  overlay.height
    property alias overlayImageX: overlay.x
    property alias overlayImageY: overlay.y

    onValueChanged: {

        var anglePerValue = (maxAngle - minAngle)/(maxValue - minValue);
        angle = Math.min(Math.max(minAngle, (value * anglePerValue) + minAngle), maxAngle);
        if (value > maxValue)
            value = maxValue;
        if (value < minValue)
            value = minValue;
    }

    Image {
        id: background
        source: "../images/meterbackground.png"
    }

    Image {
        id: needle
        smooth: true
        source: "../images/needle.png"
        width: 8
        height: 63
        x: 98
        y: 33

        transform:
            Rotation {
                id: needleRotation
                origin.x: 5
                origin.y: 65

                Behavior on angle {
                    SpringAnimation {
                        spring: 1.4
                        damping: .15
                    }
                }
            }
    }

    Image {
        id:overlay
        source: "../images/overlay.png"
        width: 148
        height: 105
        x: 21
        y: 18
    }

}
