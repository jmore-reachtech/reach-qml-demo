import QtQuick 1.1
import "../js/imagedemo.js" as JScript
import "../components"

Rectangle {
    id: root
    width: 480
    height: 272
    property int currentIndex: 0
    property int count: list.model.count
    property variant imageList: []
    signal message(string msg)


    Image{
        id: image
        anchors.fill: parent

        MouseArea{
            id: ma
            anchors.fill: parent
            property int x_pos
            property int mouseXdist: 10

            onPressed:
            {
                x_pos = mouse.x;
            }

            onReleased: {
                if ( ( (mouse.x >= x_pos) && ((mouse.x - x_pos) < mouseXdist) ) ||
                        ( (mouse.x < x_pos) && ((x_pos - mouse.x) < mouseXdist) ) )  {

                    if (mouse.x > image.width/2) {
                        currentIndex += 1;
                        if (currentIndex >= count)
                            currentIndex = 0;
                        image.source = "file:///" + imageList[currentIndex];
                    }
                    else {
                        currentIndex -= 1;
                        if (currentIndex < 0)
                            currentIndex = count - 1;
                        image.source = "file:///" + imageList[currentIndex];
                    }
                }
                else {
                    if( mouse.x > x_pos ) {
                        currentIndex -= 1;
                        if (currentIndex < 0)
                            currentIndex = count - 1;
                        image.source = "file:///" + imageList[currentIndex];
                    }
                    else {
                        currentIndex += 1;
                        if (currentIndex >= count)
                            currentIndex = 0;
                        image.source = "file:///" + imageList[currentIndex];
                    }
                }

            }
        }

        Rectangle{
            id: close
            width: 80
            height: 36
            visible: true
            anchors.right: image.right;
            anchors.rightMargin: 2
            anchors.top: image.top;
            anchors.topMargin: 2
            border.color: "red"
            border.width: 2
            color: "transparent"

            ImageButton {
                id: btnQuit
                width: 80
                height: 35
                text: "Close"
                imageUp: "images/red_up.png"
                imageDown: "images/red_down.png"
                font.pixelSize: 14
                textColor: "#ffffff"
                font.bold: false
                font.family: "DejaVu Sans"

                onButtonClick: {
                    message("imagedemo/mainview.qml");
                }
            }

            Timer{
                id: timer
                interval: 1000; running: true; repeat: true
                onTriggered: close.visible = !close.visible;
            }

        }

    }

    System{
        id: system
    }

    Rectangle{
        id: rectOpaque
        color: "#666666"
        width: 480
        height: 272
        opacity: 0.2

        Rectangle{
            id: rectMessage
            radius: 10
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            border.width: 2
            opacity: 1.0
            border.color: "#0f0f0e"
            height: 104
            width: 410
            smooth: true
            anchors.centerIn: parent
            gradient: Gradient {
                GradientStop {position: 0.0; color: "#2D2D2D"}
                GradientStop {position: 1.0; color: "#666666"}
            }

            Text{
                id: txtMessage
                height: 43
                color: "#ffffff"
                text: "Tap right or left to change images."
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.pixelSize: 16
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: image1
                x: 8
                y: 31
                width: 50
                height: 43
                smooth: true
                source: "images/leftarrow.png"
                anchors.right: txtMessage.left
            }

            Image {
                id: image2
                x: 281
                y: 31
                width: 50
                height: 43
                source: "images/rightarrow.png"
                anchors.left: txtMessage.right
            }


        }

        MouseArea{
            anchors.fill: parent
            onClicked: {rectOpaque.visible = false;}

        }


    }


    PropertyAnimation {
         id: showAnim
         target: rectOpaque
         property: "opacity"
         duration: 2000
         easing.type: Easing.InOutQuad
     }


    Component.onCompleted: {
        var images = system.execute("sh /application/src/imagedemo/files.sh " + JScript.folder);
        var list = images.split('\n');
        if (list.length > 0)
        {
            //Remove last array item as it will be blank
            console.debug("# images found: " + list.length);
			list.pop();
            image.source = list[0];
            count = list.length;			
            console.debug("# images found: " + count);
			imageList = list;
        }

        showAnim.from = 0.2;
        showAnim.to = 1.0;
        showAnim.start();
        var src1 = "import QtQuick 1.1; Timer {id: timer1; interval: 3000; running: false; repeat: false; onTriggered:{rectOpaque.visible = false;} }";
        var timer1 = Qt.createQmlObject(src1, root, "timerObject1");
        timer1.start();

    }
}
