import QtQuick 1.1
import "../components"

Rectangle {
    id: menu
    objectName: "menu"
    width: 800
    height: 480
    color: "gray"

    signal message(string msg)

    Column{
        anchors.centerIn: parent
        spacing: 20

        Row{
            spacing: 20
            ImageButton {
                width: 139
                height: 77
                text: "Bar Chart"
                imageUp: "../images/internal_button_up.bmp"
                font.pixelSize: 18
                textColor: "#000000"
                imageDown: "../images/internal_button_dn.bmp"
                font.bold: false
                font.family: "Arial"

                onButtonClick: menu.message("graphdemo/barchartview.qml");
            }

            ImageButton {
                width: 139
                height: 77
                text: "Line Chart"
                imageUp: "../images/internal_button_up.bmp"
                font.pixelSize: 18
                textColor: "#000000"
                imageDown: "../images/internal_button_dn.bmp"
                font.bold: false
                font.family: "Arial"

                onButtonClick: menu.message("graphdemo/linechartview.qml");
            }

            ImageButton {
                width: 139
                height: 77
                text: "Pie Chart"
                imageUp: "../images/internal_button_up.bmp"
                font.pixelSize: 18
                textColor: "#000000"
                imageDown: "../images/internal_button_dn.bmp"
                font.bold: false
                font.family: "Arial"

                onButtonClick: menu.message("graphdemo/piechartview.qml");
            }
        }

        Row{
            spacing: 20
            ImageButton {
                width: 139
                height: 77
                text: "Strip Chart"
                imageUp: "../images/internal_button_up.bmp"
                font.pixelSize: 18
                textColor: "#000000"
                imageDown: "../images/internal_button_dn.bmp"
                font.bold: false
                font.family: "Arial"

                onButtonClick: menu.message("graphdemo/stripchartview.qml");
            }

            ImageButton {
                width: 139
                height: 77
                text: "Heat Map"
                imageUp: "../images/internal_button_up.bmp"
                font.pixelSize: 18
                textColor: "#000000"
                imageDown: "../images/internal_button_dn.bmp"
                font.bold: false
                font.family: "Arial"

                onButtonClick: menu.message("graphdemo/heatmapview.qml");
            }

            ImageButton {
                width: 139
                height: 77
                text: "Draw Area"
                imageUp: "../images/internal_button_up.bmp"
                font.pixelSize: 18
                textColor: "#000000"
                imageDown: "../images/internal_button_dn.bmp"
                font.bold: false
                font.family: "Arial"

                onButtonClick: menu.message("graphdemo/drawareaview.qml");
            }


        }

        Row{
            spacing: 20
            ImageButton {
                width: 139
                height: 77
                text: "Scope Chart"
                imageUp: "../images/internal_button_up.bmp"
                font.pixelSize: 18
                textColor: "#000000"
                imageDown: "../images/internal_button_dn.bmp"
                font.bold: false
                font.family: "Arial"

                onButtonClick: menu.message("graphdemo/scopechartview.qml");
            }

            ImageButton {
                width: 139
                height: 77
                text: "Go Back"
                imageUp: "../images/internal_button_up.bmp"
                font.pixelSize: 18
                textColor: "#000000"
                imageDown: "../images/internal_button_dn.bmp"
                font.bold: false
                font.family: "Arial"

                onButtonClick: menu.message("../src/mainmenu.qml");
            }

        }

    }

}
