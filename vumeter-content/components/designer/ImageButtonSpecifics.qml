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
            caption: "ImageButton"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: "Text"
                            toolTip: qsTr("Text")
                        }
                        LineEdit {
                            backendValue: backendValues.text
                            baseStateFlag: isBaseState
                            translation: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox{
                            caption: "Text Color"
                            backendColor: backendValues.textColor
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: ""
                        }
                        CheckBox {
                            text: qsTr("Disable Button")
                            backendValue: backendValues.disabled
                            baseStateFlag: isBaseState
                            checkable: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Auto Repeat")
                            toolTip: qsTr("Auto Repeat")
                        }

                        CheckBox {
                            id: autoRepeatCheckBox
                            backendValue: backendValues.autoRepeat
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Interval")
                            toolTip: qsTr("Auto Repeat Interval")
                        }

                        SpinBox {
                            enabled: autoRepeatCheckBox.checked
                            opacity: enabled ? 1.0 : 0.8
                            backendValue: backendValues.autoRepeatInterval
                            singleStep: 10
                            minimum: 0
                            maximum: 10000
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
                            text: qsTr("Pressed")
                            toolTip: qsTr("Image Source for Pressed State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageDown
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Up")
                            toolTip: qsTr("Image Source for Up State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageUp
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }
            }
        }
        
        FontGroupBox {
            //finished: finishedNotify;
        }

        QScrollArea {
        }

    }
}
