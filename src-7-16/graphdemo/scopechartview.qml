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

    function getRandomInt (min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    ImageButton {
        id: image_button3
        x: 111
        y: 422
        width: 64
        height: 40
        text: "Back"
        imageUp: "../images/internal_button_up.bmp"
        font.pixelSize: 12
        textColor: "#000000"
        imageDown: "../images/internal_button_dn.bmp"
        font.bold: false
        font.family: "Arial"

        onButtonClick: root.message("graphdemo/mainview.qml");
    }


    ScopeChart{
        id: wave
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -20
        width: 600
        height: 380
        maxTime: 100
        scaleLineColor : "rgba(0,0,0,1.0)"
        scaleLineWidth : 1
        scaleShowLabels : true
        scaleLabel : "<%=value%>"
        scaleFontFamily : "DejaVu Sans"
        scaleFontSize : 10
        scaleFontStyle : "normal"
        scaleFontColor : "#666"
        scaleShowGridLines : true
        scaleGridLineColor : "rgba(50,205,50,0.5)"
        scaleGridLineWidth : 1
        datasetStrokeWidth : 2
        xPixels: 10
        line1PenColor: "#FFFFFF"
        line2PenColor: "#FFFF00"
        //line3PenColor: "#00ff00"
        //line4PenColor: "#ff0000"
    }


    //Example of a scope chart with an image background
    /*ScopeChart{
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
        scaleGridLineColor : "rgba(50,205,50,0.5)"
        scaleGridLineWidth : 1
        scaleBgColor: "transparent"
        bgColor: "transparent"
        datasetStrokeWidth : 2
        xPixels: 10
        line1PenColor: "#FFFFFF"
        line2PenColor: "#FFFF00"
        line3PenColor: "#00ff00"
        line4PenColor: "#ff0000"
        bgImage: "images/bgTest.png"
    }*/


    Component.onCompleted: {
        var timerSrc = "import QtQuick 1.1; Timer { interval: 120; running: false; repeat: true; onTriggered: {wave.currentValue1 = getRandomInt(6, 10); wave.currentValue2 = getRandomInt(0, 4);}}";
        timer1 = Qt.createQmlObject(timerSrc, root, "timerObject");
        timer1.start();
    }
}
