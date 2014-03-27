// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    width: 360
    height: 360
    color: "black"

    Rectangle {
        id: mSpinner

        anchors.centerIn: parent
        width: 300
        height: width
        radius: 20
        color: "gray"

        ListView {
            id: list
            anchors.fill: parent
            clip: true

            snapMode: ListView.SnapToItem
            model: 10
            delegate: Rectangle{
              width: list.width
              height: list.height
              color: "transparent"
              //rotation: (index % 2) ? -10 : 10

              Text {
                  anchors.centerIn: parent
                  horizontalAlignment: Text.AlignHCenter
                  text: index
                  font.pixelSize: list.width
              }
            }

            onCurrentIndexChanged: console.log("CURRENT INDEX " + list.currentIndex)
            onMovementEnded: list.currentIndex = list.visibleArea.yPosition * list.count

            // Workaround: Compute visibleArea
            Component.onCompleted: list.visibleArea
        }

        Rectangle {
            id: overlay
            anchors.fill: parent
            gradient: Gradient {
                     GradientStop { position: 0.0; color: "black" }
                     GradientStop { position: 0.18; color: "transparent" }
                     GradientStop { position: 0.33; color: "white" }
                     GradientStop { position: 0.66; color: "transparent" }
                     GradientStop { position: 1.0; color: "black" }
            }
        }
    }
}
