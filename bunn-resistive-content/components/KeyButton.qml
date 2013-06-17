import QtQuick 1.1

BorderImage {
    id: button

    property alias text: buttonText.text
    property string op: buttonText.op
    property alias shiftText: buttonShiftText.text
    property string shiftOp: buttonShiftText.op
    property alias textColor: buttonText.color
    property alias fontFamily: buttonText.font.family

    signal clicked(string op)

    width: 24
    height: 34

    source: "../images/key.png"; clip: false
    asynchronous: true
    border { left: 10; top: 10; right: 10; bottom: 10 }

    Rectangle {
        id: shade
        anchors {fill: button;}
        radius: 10;
        color: "black";
        opacity: 0
    }

    Text {
        id: buttonText
        property string op
        anchors { centerIn: parent; }
        font.family: "Verdana"
        font.pixelSize: parent.width > parent.height ? Math.floor(parent.height * .5) : Math.floor(parent.width * .6)
        style: Text.Sunken;
        //styleColor: "black";
        smooth: false
    }

    Text {
        id: buttonShiftText
        property string op
        anchors {
            top: parent.top
            right: parent.right
            rightMargin: 8
        }

        font.pixelSize: parent.width > parent.height ? parent.height * .3 : parent.width * .3
        color: "white";
        styleColor: "black";
        smooth: false
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: button.clicked(op)
    }

    states: State {
        name: "pressed"; when: mouseArea.pressed == true
        PropertyChanges { target: shade; opacity: .3 }
    }
}
