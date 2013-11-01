import QtQuick 1.1
import "components"

Rectangle {
    id: root
    objectName: "root"
    width: 480
    height: 272
    property int page: 0
    property string swipe

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

          if(Math.abs(xDiff) > 10 && Math.abs(xDiff) > Math.abs(yDiff) ) {
              if( oldX > mouseX) {
                  imgSwipe.x = 0;
                  imgSwipe.y = root.height - imgSwipe.height - 4;
                  imgSwipe.source = "images/right_swipe.png";
                  imgSwipe.visible = true;
                  root.swipe = "left";
                  timer1.start();
                  //onLeftSwipe();
              } else {
                  imgSwipe.x = root.width - imgSwipe.width;
                  imgSwipe.y = root.height - imgSwipe.height - 4;
                  imgSwipe.source = "images/left_swipe.png";
                  imgSwipe.visible = true;
                  timer1.start();
                  root.swipe = "right";
                  //onRightSwipe();
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

    BorderImage {
        id: imgSwipe
        x: 41
        y: 146
        width: 34
        height: 28
        visible: false
        smooth: true
        source: "images/right_swipe.png"
    }

    Timer{
        id: timer1
        interval: 100; running: false; repeat: false
        onTriggered: {
            imgSwipe.visible = false;
            if (root.swipe == "left")
                onLeftSwipe();
            else
                onRightSwipe();
        }
    }

    Component.onCompleted: {
        currentPage = "Buttons1";
    }
}
