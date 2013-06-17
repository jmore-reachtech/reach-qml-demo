import QtQuick 1.1

Rectangle {
            id:comboBox
            property alias selectedName: chosenItemText.text;
            property string selectedValue: comboItems.get(listView.currentIndex).value;
            signal comboClicked;
            width: 120;
            height: 20;
            z: 100;
            smooth:true;
            property ListModel comboItems: ListModel {}
            property alias currentIndex: listView.currentIndex
            property alias fontPixelSize: chosenItemText.font.pixelSize

            Rectangle {
                id:chosenItem
                radius:0;
                width:parent.width;
                height:parent.height;
                color: "White"
                smooth:true;
                Text {
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.leftMargin: 2
                    height: 20
                    id:chosenItemText
                    text:comboItems.get(listView.currentIndex).name;
                    font.family: "Arial"
                    font.pixelSize: 16;
                    smooth:true
                }
                Image {
                    id: imgButton
                    anchors.top: parent.top;
                    anchors.left: parent.right;
                    width: 20
                    height: 20
                    source: "../images/dropdownoff.png"

                    MouseArea {
                        anchors.fill: parent;
                        onClicked: {
                            comboBox.state = comboBox.state==="dropDown"?"":"dropDown"

                            if (imgButton.source.toString().indexOf("dropdownoff.png") > 0)
                                imgButton.source = "../images/dropdownon.png";
                            else
                                imgButton.source = "../images/dropdownoff.png";
                        }
                    }
                }


            }

            Rectangle {
                id:dropDown
                width:comboBox.width;
                height:0;
                clip:true;
                radius:8;
                anchors.top: chosenItem.bottom;
                anchors.margins: 1;
                color: "#444444"
                z:1000

                ListView {
                    id:listView
                    height: (comboItems.count+3) * 14;
                    model: comboItems
                    highlight: Rectangle{ color: "blue" }
                    currentIndex: 0

                    delegate: Item{
                        width:comboBox.width;
                        height: comboBox.height;

                        Column{
                            id: col
                            width: parent.width;
                            Text {
                                text: name
                                anchors.left: parent.left;
                                anchors.margins: 4;
                                font.pixelSize: chosenItemText.font.pixelSize
                                font.family: "Arial"
                                font.bold: false
                                color: "White"
                                verticalAlignment: Text.AlignVCenter
                        }
                            Rectangle {
                                color: "Gray";
                                height: 1
                                width:  parent.width;
                            }
                        }

                        MouseArea {
                            anchors.fill: parent;
                            onClicked: {
                                comboBox.state = ""
                                var prevSelection = chosenItemText.text
                                chosenItemText.text = name
                                if(chosenItemText.text != prevSelection){
                                    comboBox.comboClicked();
                                }

                                listView.currentIndex = index;
                                imgButton.source = "../images/dropdownoff.png"
                            }
                        }
                    }



                }


            }


            states: State {
                name: "dropDown";
                PropertyChanges { target: dropDown; height: 14 * (listView.count + 3) }
            }

            transitions: Transition {
                NumberAnimation { target: dropDown; properties: "height"; easing.type: Easing.OutExpo; duration: 1000 }
            }
        }

