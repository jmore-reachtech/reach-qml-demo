import QtQuick 1.1
import "components"

Rectangle {
    id: root
    width: 480
    height: 272
    gradient: Gradient {
        GradientStop {
            position: 0.16
            color: "#afacac"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }

    signal message(string msg)

    VerticalSlider {
        id: slider___vertical1
        x: 414
        y: 24
        width: 48
        height: 184
        imageHandle: "images/slider_handle.png"
        allowDrag: true
        yMin: 2
        value: -20
        maximum: 4
        imageTrack: "images/slider_track.bmp"
        minimum: -20
        handleX: 0

        onValueChanged: vu_meter1.value = value;
    }

    VUMeter {
        id: vu_meter1
        x: 18
        y: 23
        width: 377
        height: 242
        needleImage: "images/vu_needle.png"
        overlayImageHeight: 26
        needleImageHeight: 139
        overlayImage: "images/vu_overlay.png"
        value: -20
        needleImageWidth: 8
        needleRotationY: 139
        needleRotationX: 4
        overlayY: 191
        overlayImageWidth: 39
        overlayX: 168
        needleY: 57
        needleX: 181
        backgroundImage: "images/vu_background.png"
    }

    ImageButton {
        id: quitButton
        x: 414
        y: 225
        width: 48
        height: 48
        text: ""
        imageDown: "images/quit_down.png"
        imageUp: "images/quit_up.png"
        onButtonClick: launcher.launchScript("main-content");
    }

    MouseArea {
        id: mouseArea
        x: 18
        y: 0
        width: 377
        height: 42

        onPressed : {
            root.message("spinner.qml");
        }
    }



    ScriptLauncher {
         id: launcher
    }

}
