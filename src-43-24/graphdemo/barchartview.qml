import QtQuick 1.1
import "../components"

Rectangle {
    id: root
    width: 480
    height: 272
    color: "#eeeeee"
    property int test: 0

    signal message(string msg)



    ImageButton {
        id: image_button1
        x: 20
        y: 219
        width: 98
        height: 31
        text: "Change Data"
        imageUp: "../images/internal_button_up.bmp"
        font.pixelSize: 12
        textColor: "#000000"
        imageDown: "../images/internal_button_dn.bmp"
        font.bold: false
        font.family: "Arial"

        onButtonClick: {
            if (test === 0)
            {
                var d = "{labels : [\"A\",\"B\",\"C\",\"D\",\"E\",\"F\",\"G\"], datasets : [{text: \"Series 1\", fillColor : \"rgba(79,129,188,0.6)\", strokeColor : \"rgba(79,129,188,0.6)\", pointColor : \"rgba(79,129,188,0.6)\", pointStrokeColor : \"#fff\", data : [5,10,1,1,6,5,0] }, { text: \"Series 2\", fillColor : \"rgba(35,191,170, 0.6)\", strokeColor : \"rgba(35,191,170, 0.6)\", pointColor : \"rgba(35,191,170, 0.6)\", pointStrokeColor : \"#fff\", data : [8,8,0,9,6,7,10] } ] }";
                 var testData = eval('(' + d + ')');
                 chart.data = testData;
                 chart.scaleFontSize += 2;
                 chart.draw();
                 test += 1;
            }
            else
            {
                var d1 = "{labels : [\"Jan\",\"Feb\",\"March\",\"April\",\"May\",\"June\",\"July\"], datasets : [{text: \"Data 1\", fillColor : \"rgba(220,220,220,0.5)\",strokeColor : \"rgba(220,220,220,1)\",data : [65,59,90,81,56,55,40]},{text: \"Data 2\", fillColor : \"rgba(151,187,205,0.5)\",strokeColor : \"rgba(151,187,205,1)\",data : [28,48,40,19,96,27,100]}]}";
                var testData1 = eval('(' + d1 + ')');
                chart.data = testData1;

                chart.scaleFontSize -= 2;
                chart.draw();
                test -= 1;
            }

        }
    }

    ImageButton {
        id: image_button3
        x: 130
        y: 219
        width: 60
        height: 31
        text: "Back"
        imageUp: "../images/internal_button_up.bmp"
        font.pixelSize: 12
        textColor: "#000000"
        imageDown: "../images/internal_button_dn.bmp"
        font.bold: false
        font.family: "Arial"

        onButtonClick: root.message("graphdemo/mainview.qml");
    }

    BarChart {
        id: chart
        x: 20
        y: 17
        width: 440
        height: 180
        scaleShowGridLines: true
        showLegend: true
        scaleLineWidth: 1
        scaleFontStyle: "normal"
        barStrokeWidth: 2
        scaleOverlay: true
        scaleLabel: "<%=value%>"
        barDatasetSpacing: 1
        scaleLineColor: "rgba(0,0,0,0.1)"
        barShowStroke: true
        scaleFontFamily: "DejaVu Sans"
        scaleShowLabels: true
        scaleFontColor: "#666"
        scaleGridLineColor: "rgba(0,0,0,0.05)"
        barValueSpacing: 5
        scaleFontSize: 10
        scaleGridLineWidth: 1
    }


}
