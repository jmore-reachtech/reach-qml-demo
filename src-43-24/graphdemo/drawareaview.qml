import QtQuick 1.1
import "../components"

Rectangle {
    id: root
    objectName: "root"
    width: 480
    height: 272
    color: "#eeeeee"

    signal message(string msg)

    DrawArea{
        id: da
        x: 20
        y: 38
        width: 441
        height: 67
        color: "white"
    }

    Canvas{
        id: sig
        x: 20
        y: 130
        width: 441
        height: 67
        color: "white"

        function clear()
        {
            var ctx = sig.getContext();
            ctx.fillStyle = "#eeeeee";
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
        x: 15
        y: 219
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
        x: 20
        y: 12
        text: "Enter Signature"
        font.pixelSize: 14
    }

    ImageButton {
        id: image_button2
        x: 82
        y: 219
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
        x: 147
        y: 219
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
