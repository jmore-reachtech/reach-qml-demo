import QtQuick 1.0

Dial {

    id: metronomemeter
    value: -56
    min: -56
    max: 56
    // Width and height dictated by the background image
    width: 325; height: 158

    // Set the images
    backgroundImage: "../images/met_dial_background.png"
    needleImage: "../images/met_needle.png"
    needleImageWidth: 20
    needleImageHeight: 100

    overlayImage: ""
    overlayImageWidth: 0
    overlayImageHeight: 0

    // Set the needle position
    needleX: 153
    needleY: 19
    // Set the overlay image position
    overlayX: 0
    overlayY: 0
    // Set the position of the needle image where the rotation moves around
    needleRotationX: 10
    needleRotationY: 100
    // Set the initial angle of the needle rotation
    angle: 0

    onValueChanged: {
        angle = value;
    }
}
