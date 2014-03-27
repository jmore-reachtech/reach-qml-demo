import QtQuick 1.1
import "../components"

Rectangle {
    id: root
    objectName: "root"
    width: 800
    height: 480
    color: "#eeeeee"
    property variant timer1

    signal message(string msg)

    HorizontalSlider {
        id: slider
        x: 186
        y: 409
        width: 260
        height: 46
        hintBorderColor: "#000000"
        showHint: true
        maximum: 10
        hintBorderWidth: 2
        hintFontFamily: "Arial"
        hintBackgroundColor: "#ffffff"
        hintFontColor: "#000000"
        hintFontPixelSize: 16
        imageTrack: "../images/slider_htrack.png"
        minimum: -10
        xMin: 0
        value: 0
        handleY: 2
        imageOverlay: ""
        hintRadius: 9
        hintWidth: 40
        imageHandle: "../images/slider_handle.png"
        allowDrag: true
        hintHeight: 40

        onValueChanged: timer1.start();
    }

    ImageButton {
        id: image_button3
        x: 110
        y: 425
        width: 60
        height: 30
        text: "Back"
        imageUp: "../images/internal_button_up.bmp"
        font.pixelSize: 12
        textColor: "#000000"
        imageDown: "../images/internal_button_dn.bmp"
        font.bold: false
        font.family: "Arial"

        onButtonClick: root.message("graphdemo/mainview.qml");
    }

    StripChart {
        id: wave
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -20
        width: 600
        height: 380
        scaleShowGridLines: true
        datasetStrokeWidth: 2
        bgColor: "#EEEEEE"
        scaleLineWidth: 1
        scaleBgColor: "#000000"
        scaleFontStyle: "normal"
        scaleLabel: "<%=value%>"
        maxTime: 100
        scaleLineColor: "rgba(0,0,0,1.0)"
        maxYValue: 10
        scaleFontFamily: "DejaVu Sans"
        scaleShowLabels: true
        scaleFontColor: "#666"
        minTime: 0
        minYValue: -10
        scaleGridLineColor: "rgba(50,205,50,0.5)"
        scaleFontSize: 8
        scaleGridLineWidth: 1
        line1PenColor: "#ffffff"
        line2PenColor: "#FFFF00"
        //line3PenColor: "#00ff00"
        //line4PenColor: "#ff0000"
    }

    //Example of a strip chart with an image background
    /*StripChart{
        id: wave
        x: 40
        y: 20
        width: 400
        height: 200
        maxTime: 100
        scaleLineColor : "rgba(0,0,0,0)"
        scaleLineWidth : 1
        scaleShowLabels : false
        scaleLabel : "<%=value%>"
        scaleFontFamily : "DejaVu Sans"
        scaleFontSize : 10
        scaleFontStyle : "normal"
        scaleFontColor : "#666"
        scaleShowGridLines : false
        scaleGridLineColor : "rgba(0,0,0,0)"
        scaleGridLineWidth : 1
        scaleBgColor: "transparent"
        bgColor: "transparent"
        datasetStrokeWidth : 2
        line1PenColor: "#ffffff"
        line2PenColor: "#FFFF00"
        line3PenColor: "#00ff00"
        line4PenColor: "#ff0000"
        bgImage: "images/bgTest.png"
    }*/


    Component.onCompleted: {
        var timerSrc = "import QtQuick 1.1; Timer { interval: 30; running: false; repeat: true; onTriggered: { wave.currentValue1 = slider.value; wave.currentValue2 = slider.value - 2; wave.currentValue3 = slider.value + 3; wave.currentValue4 = slider.value - 4;}}";
        timer1 = Qt.createQmlObject(timerSrc, root, "timerObject");

    }
}
