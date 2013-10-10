import HelperWidgets 1.0
import QtQuick 1.0
import Bauhaus 1.0


QWidget {
    layout: QVBoxLayout {
        topMargin: 0
        bottomMargin: 0
        leftMargin: 0
        rightMargin: 0
        spacing: 0

        GroupBox {
            caption: "Horizontal Switch Group"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox{
                            caption: "Text On Color"
                            backendColor: backendValues.textOnColor
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox{
                            caption: "Text Off Color"
                            backendColor: backendValues.textOffColor
                            baseStateFlag: isBaseState
                        }
                    }
                }

            }
        }

        GroupBox {
            caption: qsTr("Image Sources")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("On")
                            toolTip: qsTr("Image Source for On State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOn
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Off")
                            toolTip: qsTr("Image Source for Off State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOff
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.svg"
                            showComboBox: true
                        }
                    }
                }
            }
        }

        IntEditor {
            backendValue: backendValues.spacing

            caption: qsTr("Button Spacing")
            baseStateFlag: isBaseState;

            step: 1;
            minimumValue: 0;
            maximumValue: 100;
        }

        FontGroupBox {
            //finished: finishedNotify;
        }

        QScrollArea {
        }

    }
}


