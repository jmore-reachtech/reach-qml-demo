import QtQuick 1.1
import "../components"

Rectangle {
    id: root
    objectName: "root"
    width: 480
    height: 272
    property int page: 0
    property string swipe
    // Set this property to another file name to change page
    property string  currentPage : "";

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

    ListModel{
        id: pageList

        ListElement{
            page: "Buttons1"
        }
        ListElement{
            page: "Buttons2"
        }
        ListElement{
            page: "Sliders"
        }
        ListElement{
            page: "Indicators1"
        }
        ListElement{
            page: "Indicators2"
        }
        ListElement{
            page: "DataEntry"
        }
        ListElement{
            page: "Knobs"
        }
        ListElement{
            page: "Meters"
        }
    }

    ListView {
        id: view
        contentHeight: 272
        width: 480
        height: 272
        model: pageList
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem;
        flickDeceleration: 500
        boundsBehavior: Flickable.StopAtBounds

        onFlickEnded: {
            var index = view.contentX/480;
            root.page = index;
            updatePageIndicator();
        }


        delegate: Component{
            Loader {
                id: loader
                property string pageName: page
                property bool beenLoaded: false
                width: 480
                height: 272
                source: "%1.qml".arg(page)
            }

        }

    }

    Rectangle {
        id: rectPager
        width: root.width
        height: 14
        color: "transparent"
        anchors.bottom: root.bottom

        Row{
            id: rowPager
            spacing: 5
            anchors.centerIn: parent

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

    function createPageIndicator()
    {
        for (var i=0; i < view.model.count; i++)
        {
            var src = "";
            if ( i == root.page)
                src = "import QtQuick 1.1; Rectangle{color: \"white\"; border.width: 1; border.color: \"black\";  width: 8; height: 8; radius: width/2; smooth: true}"
            else
                src = "import QtQuick 1.1; Rectangle{color: \"#666666\"; width: 8; height: 8; border.width: 1; border.color: \"black\"; radius: width/2; smooth: true}"

            var rect = Qt.createQmlObject(src, rowPager, "rectPageIndicator" + i.toString());
        }

    }

    function updatePageIndicator()
    {
        for(var i = 0; i < rowPager.children.length ; i++) {
            if (i == root.page)
                rowPager.children[i].color = "white";
            else
                rowPager.children[i].color = "#666666";
        }
    }

    Component.onCompleted: {
        currentPage = "Buttons1";
        createPageIndicator();
    }
}
