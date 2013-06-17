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
            caption: "Vertical Level Indicator"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Start Position")
                            toolTip: qsTr("Start position of overlay image")
                        }

                        ComboBox {
                            id: startPositionComboBox
                            backendValue: backendValues.startPosition
                            currentText: backendValues.startPosition.value
                            baseStateFlag: isBaseState
                            items: ["top", "bottom"]
                            onItemsChanged: {
                                currentText =  backendValues.startPosition.value;
                            }
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Offset")
                            toolTip: qsTr("Offset")
                        }

                        SpinBox {
                            backendValue: backendValues.offSet
                            singleStep: 1
                            minimum: 0
                            maximum: 100
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Increment")
                            toolTip: qsTr("Increment")
                        }

                        SpinBox {
                            backendValue: backendValues.increment
                            singleStep: 1
                            minimum: 0
                            maximum: 100
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Min Value")
                            toolTip: qsTr("Min Value")
                        }

                        SpinBox {
                            backendValue: backendValues.minValue
                            singleStep: 1
                            minimum: -1000
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Max Value")
                            toolTip: qsTr("Max Value")
                        }

                        SpinBox {
                            backendValue: backendValues.maxValue
                            singleStep: 1
                            minimum: 0
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Value")
                            toolTip: qsTr("Start Value")
                        }

                        SpinBox {
                            backendValue: backendValues.value
                            singleStep: 1
                            minimum: -1000
                            maximum: 1000
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
                            text: qsTr("Base Image")
                            toolTip: qsTr("Image Source for Base Image")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageBase
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Overlay Image")
                            toolTip: qsTr("Image Source for Overlay Image")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOverlay
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.svg"
                            showComboBox: true
                        }
                    }
                }
            }
        }

        QScrollArea {
        }

    }
}
