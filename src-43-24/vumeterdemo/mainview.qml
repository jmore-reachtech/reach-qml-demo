import QtQuick 1.1
import "../components"

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

    VUMeter {
        id: vu_meter1
        x: 18
        y: 15
        width: 377
        height: 242
        needleImage: "../images/vu_needle.png"
        overlayImageHeight: 26
        needleImageHeight: 139
        overlayImage: "../images/vu_overlay.png"
        value: -20
        needleImageWidth: 8
        needleRotationY: 139
        needleRotationX: 4
        overlayY: 191
        overlayImageWidth: 39
        overlayX: 168
        needleY: 57
        needleX: 181
        backgroundImage: "../images/vu_background.png"

        Spinner {
            id: spinner2
            x: 384
            y: 2
            width: 68
            height: 187
            color: "#ffffff"
            radius: 2
            initialIndex: 0
            textColor: "#000000"
            font.pixelSize: 25
            border.color: "#000000"
            border.width: 3
            backGroundImage: "images/spinner-bg.png"
            highlightImage: "images/spinner-select.png"
            font.bold: false
            font.family: "Arial"
            model: ListModel {
                ListElement {
                    index: -20
                    value: -20
                }
                ListElement {
                    index: -19
                    value: -19
                }
                ListElement {
                    index: -18
                    value: -18
                }
                ListElement {
                    index: -17
                    value: -17
                }
                ListElement {
                    index: -16
                    value: -16
                }
                ListElement {
                    index: -15
                    value: -15
                }
                ListElement {
                    index: -14
                    value: -14
                }
                ListElement {
                    index: -13
                    value: -13
                }
                ListElement {
                    index: -12
                    value: -12
                }
                ListElement {
                    index: -11
                    value: -11
                }
                ListElement {
                    index: -10
                    value: -10
                }
                ListElement {
                    index: -9
                    value: -9
                }
                ListElement {
                    index: -8
                    value: -8
                }
                ListElement {
                    index: -7
                    value: -7
                }
                ListElement {
                    index: -6
                    value: -6
                }
                ListElement {
                    index: -5
                    value: -5
                }
                ListElement {
                    index: -4
                    value: -4
                }
                ListElement {
                    index: -3
                    value: -3
                }
                ListElement {
                    index: -2
                    value: -2
                }
                ListElement {
                    index: -1
                    value: -1
                }
                ListElement {
                    index: 0
                    value: 0
                }
                ListElement {
                    index: 1
                    value: 1
                }
                ListElement {
                    index: 2
                    value: 2
                }
                ListElement {
                    index: 3
                    value: 3
                }
            }

            itemHeight: 29

            onCurrentIndexChanged: {
                vu_meter1.value = spinner2.model.get(currentIndex).value;
            }
        }
    }

    ImageButton {
        id: quitButton
        x: 413
        y: 209
        width: 48
        height: 48
        text: ""
        imageDown: "../images/quit_down.png"
        imageUp: "../images/quit_up.png"
        onButtonClick: root.message("../src/mainmenu.qml");
    }


}
