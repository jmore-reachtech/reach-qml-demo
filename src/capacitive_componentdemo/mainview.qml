import QtQuick 1.1
import "components"

Rectangle {
    id: root
    objectName: "root"
    width: 480
    height: 272
    property int page: 0

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

    // Put the name of the QML files containing your pages (without the '.qml')
    property variant pagesList  : [
      "Buttons1",
      "Buttons2",
      "Sliders",
      "Indicators1",
      "Indicators2",
      "DataEntry",
      "Knobs",
      "Meters"
    ];

    // Set this property to another file name to change page
    property string  currentPage : "";

    // function to switch view on swipe
    function onLeftSwipe() {
        root.page += 1;
        if (root.page > repeater.count-1)
            root.page = repeater.count-1;
        currentPage = repeater.itemAt(root.page).pageName;
    }

    function onRightSwipe() {
        root.page -= 1;
        if (root.page < 0)
            root.page = 0;
        currentPage = repeater.itemAt(root.page).pageName;
    }

    // swipe detection code
    MouseArea {
        id: mouseArea
        anchors.fill: parent;

        property int oldX: 0
        property int oldY: 0

      onPressed: {
        oldX = mouseX;
        oldY = mouseY;
      }

      onReleased: {
          var xDiff = oldX - mouseX;
          var yDiff = oldY - mouseY;

          if(Math.abs(xDiff) > 50 && Math.abs(xDiff) > Math.abs(yDiff) ) {
              if( oldX > mouseX) {
                    onLeftSwipe();
              } else {
                    onRightSwipe();
              }
          } else {
              if( oldY > mouseY) {/*up*/ }
              else {/*down*/ }
          }
       }

    }

    Repeater {
        id: repeater
        model: pagesList;
        delegate: Loader {
            id: loader
            property string pageName: modelData
            property bool beenLoaded: false
            anchors.fill: parent
            visible: (currentPage === modelData);
            //source: "%1.qml".arg(modelData)
            onVisibleChanged: {
                if (visible && !beenLoaded)
                {
                    source = "%1.qml".arg(pageName);
                    beenLoaded = true;
                }
            }

        }
    }

    Component.onCompleted: currentPage = "Buttons1";
}
