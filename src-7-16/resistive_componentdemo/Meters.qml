import QtQuick 1.1
import "../components"

Rectangle {
    id: root
    objectName: "root"
    width: 800
    height: 480
    signal message(string msg)

    Image{
        source: "../capacitive_componentdemo/images/meterdemobgd.png"
        anchors.fill: parent

        Text {
            id: txtTitle
            x: 0
            y: 66
            width: parent.width
            text: qsTr("Meters")
            horizontalAlignment: Text.AlignHCenter
            font.bold: false
            font.pixelSize: 26


        }

        Speedometer {
            id: speedometer2
            x: 436
            y: 131
            width: 215
            height: 217
            minAngle: -112
            needleImage: "../capacitive_componentdemo/images/needle.png"
            overlayImageHeight: 40
            min: 0
            needleImageHeight: 79
            overlayImage: "../capacitive_componentdemo/images/speedometer_overlay.png"
            value: 0
            needleImageWidth: 8
            max: 80
            needleRotationY: 76
            needleRotationX: 5
            maxAngle: 113
            overlayY: 80
            overlayImageWidth: 40
            overlayX: 95
            needleY: 24
            needleX: 110
            backgroundImage: "../capacitive_componentdemo/images/rpm_base.png"
        }


        Speedometer {
            id: speedometer1
            x: 145
            y: 108
            width: 244
            height: 245
            minAngle: -126
            smooth: false
            needleImage: "../capacitive_componentdemo/images/needle.png"
            overlayImageHeight: 46
            min: 0
            needleImageHeight: 88
            overlayImage: "../capacitive_componentdemo/images/speedometer_overlay.png"
            value: 0
            needleImageWidth: 8
            max: 180
            needleRotationY: 86
            needleRotationX: 4
            maxAngle: 126
            overlayY: 91
            overlayImageWidth: 47
            overlayX: 104
            needleY: 28
            needleX: 122
            backgroundImage: "../capacitive_componentdemo/images/speedometer_base.png"

            onValueChanged: text1.text = value.toFixed(0).toString();
            Text {
                id: text1
                x: 100
                y: 158
                width: 54
                height: 19
                color: "#12cf19"
                text: qsTr("0")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
            }

        }
    }

    HorizontalSlider {
        id: slider___horizontal1
        x: 256
        y: 367
        width: 288
        height: 32
        xMax: 247
        hintBorderColor: "#000000"
        showHint: false
        maximum: 180
        hintBorderWidth: 2
        hintFontFamily: "Arial"
        hintBackgroundColor: "#ffffff"
        hintFontColor: "#000000"
        hintFontPixelSize: 16
        imageOverlay: "../capacitive_componentdemo/images/slider_fg.png"
        imageTrack: "../capacitive_componentdemo/images/slider_bg.png"
        minimum: 0
        xMin: 0
        value: 0
        handleY: 0
        hintRadius: 9
        hintWidth: 40
        imageHandle: "../capacitive_componentdemo/images/handle.png"
        allowDrag: true
        hintHeight: 40

        onValueChanged: {
            speedometer1.value = value;
            speedometer2.value = 38.23 * speedometer1.value / 100.0;
        }
    }

}




