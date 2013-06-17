import QtQuick 1.1

Item {
    id: progressbar

    property int minimum: 0
    property int maximum: 100
    property int value: 0
    property color color: "Green"

    width: 23; height: 250
    clip: true

    Rectangle {
        id: border
        anchors.fill: parent
        anchors.bottomMargin: 1
        anchors.rightMargin: 1
        color: "transparent"
        border.width: 1
        border.color: parent.color
    }

    Rectangle {
        id: highlight
        property int heightDest: ( ( progressbar.height * ( value - minimum ) ) / ( maximum - minimum ) - 4 )
        height: highlight.heightDest

        Behavior on height {
            SmoothedAnimation {
                velocity: 1200
            }
        }

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 2
        }
        color: parent.color
    }
}
