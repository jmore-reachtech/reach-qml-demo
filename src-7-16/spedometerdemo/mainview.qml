import QtQuick 1.1
import "../components"

Rectangle {
    id: root
    objectName: "root"
    width: 800
    height: 480

    signal message(string msg)

    Image{
        source: "../images/bg.png"
        anchors.fill: parent
    }

    Speedometer {
        id: spedo
        x: 238
        y: 135
        objectName: "spedo"
        width: 210
        height: 210
        needleImage: "../images/needle.png"
        overlayImageHeight: 105
        min: 0
        needleImageHeight: 63
        overlayImage: "../images/overlay.png"
        value: 0
        needleImageWidth: 8
        max: 120
        needleRotationY: 65
        needleRotationX: 5
        maxAngle: 133
        overlayY: 18
        overlayImageWidth: 148
        overlayX: 21
        needleY: 33
        needleX: 98
        backgroundImage: "../images/meterbackground.png"
    }

    VerticalSlider {
        id: slider___vertical1
        x: 492
        y: 148
        width: 48
        height: 184
        imageHandle: "../images/slider_handle.png"
        allowDrag: true
        yMin: 0
        value: 0
        maximum: 120
        imageTrack: "../images/slider_track.bmp"
        minimum: 0
        handleX: 0

        onValueChanged: spedo.value = value;
    }

    ImageButton {
        id: quitButton
        x: 724
        y: 410
        width: 48
        height: 48
        text: ""
        imageDown: "../images/quit_down.png"
        imageUp: "../images/quit_up.png"
        onButtonClick: root.message("../src/mainmenu.qml");
    }


}
