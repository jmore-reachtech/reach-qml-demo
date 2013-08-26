// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1



Image {
    id: spinner
    property string displayText: ""
    property bool addDisplayText: false
    property real min: 0
    property real max: 10
    property real value: 0
    property real increment: 1
    property int precision: 0
    fillMode: Image.TileHorizontally
    source: "../images/bg_spinner.png"
    asynchronous: true
    width: 100
    height: 30

    onValueChanged: {
        if (value < min)
            value = min;
        else if (value > max)
            value = max;

    }

    ImageButton {
        id: btnLeft
        anchors.left: parent.left
        width: parent.height
        height: parent.height
        imageOn: "../images/left_arrow_spin.png"
        imageOff: "../images/left_arrow_spin_off.png"
        onButtonClick: {
            value -= increment;
            if (value < min)
            {
                value = min;
                btnLeft.enabled = false;
                btnLeft.opacity = 0.6;
            }
            else
            {
                btnRight.enabled = true;
                btnRight.opacity = 1.0;
            }
        }
    }

    ImageButton {
        id: btnRight
        anchors.right: parent.right
        width: parent.height
        height: parent.height
        anchors.rightMargin: 0
        imageOn: "../images/right_arrow_spin.png"
        imageOff: "../images/right_arrow_spin_off.png"
        onButtonClick: {
            value += increment;
            if (value > max)
            {
                value = max;
                btnRight.enabled = false;
                btnRight.opacity = 0.6;
            }
            else
            {
                btnLeft.enabled = true;
                btnLeft.opacity = 1.0;
            }
        }
    }

    Text{
        id: txtNumber
        height: parent.height
        text: spinner.addDisplayText ? parent.value.toFixed(parent.precision) + parent.displayText
                                     : parent.value.toFixed(parent.precision)
        font.pixelSize: 16
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.left: btnLeft.right
        anchors.right: btnRight.left

    }
}
