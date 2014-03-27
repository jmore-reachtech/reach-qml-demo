import QtQuick 1.1
import "../components"

Rectangle {
    id: root
    objectName: "root"
    width: 800
    height: 480
    color: "#eeeeee"

    signal message(string msg)

    DrawArea{
        id: da
        x: 65
        y: 86
        width: 657
        height: 122
        color: "white"
    }

    Canvas{
        id: sig
        x: 65
        y: 220
        width: 657
        height: 122
        color: "white"

        function clear()
        {
            var ctx = sig.getContext();
            ctx.fillStyle = "#ffffff";
            ctx.fillRect(0, 0, width, height);
        }

        function draw(data)
        {
            var ctx = sig.getContext();
            ctx.fillStyle = "white";
            ctx.fillRect(0, 0, width, height);
            //var pixels = ctx.getImageData(0,0,width, height);
            ctx.putImageData(data, 0, 0);
        }
    }

    ImageButton {
        id: image_button1
        x: 65
        y: 360
        width: 60
        height: 26
        text: "Copy"
        imageUp: "../images/internal_button_up.bmp"
        font.pixelSize: 12
        textColor: "#000000"
        imageDown: "../images/internal_button_dn.bmp"
        font.bold: false
        font.family: "Arial"

        onButtonClick: {
            sig.draw(da.getPixels());
        }
    }

    Text {
        id: text1
        x: 65
        y: 60
        text: "Enter Signature"
        font.pixelSize: 14
    }

    ImageButton {
        id: image_button2
        x: 132
        y: 360
        width: 60
        height: 26
        text: "Clear"
        imageUp: "../images/internal_button_up.bmp"
        font.pixelSize: 12
        textColor: "#000000"
        imageDown: "../images/internal_button_dn.bmp"
        font.bold: false
        font.family: "Arial"

        onButtonClick: {
            sig.clear();
            da.clear();
        }
    }

    ImageButton {
        id: image_button3
        x: 197
        y: 360
        width: 60
        height: 26
        text: "Back"
        imageUp: "../images/internal_button_up.bmp"
        font.pixelSize: 12
        textColor: "#000000"
        imageDown: "../images/internal_button_dn.bmp"
        font.bold: false
        font.family: "Arial"

        onButtonClick: root.message("graphdemo/mainview.qml");
    }

}
