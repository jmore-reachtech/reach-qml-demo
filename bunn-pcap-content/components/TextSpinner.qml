import QtQuick 1.1

Image {
    id: spinner
    property int currentValue: 0
    property string currentText: ""
    property int currentIndex: 0
    property int count: items.count-1
    property ListModel items: ListModel {}

    fillMode: Image.TileHorizontally
    source: "../images/bg_spinner.png"
    width: 100
    height: 30

    ImageButton {
        id: btnLeft
        anchors.left: parent.left
        width: parent.height
        height: parent.height
        imageOn: "../images/left_arrow_spin.png"
        imageOff: "../images/left_arrow_spin_off.png"
        opacity: parent.currentIndex > 0 ? 1.0 : 0.6
        enabled: parent.currentIndex > 0 ? true : false


        onButtonClick: {
            parent.currentIndex -= 1;
            if (parent.currentIndex <= 0)
            {
                parent.currentIndex = 0;
            }

            parent.currentValue = parent.items.get(currentIndex).value;
            parent.currentText = parent.items.get(currentIndex).text;
        }
    }

    ImageButton {
        id: btnRight
        anchors.right: parent.right
        width: parent.height
        height: parent.height
        anchors.rightMargin: 0
        imageOn: "../images/right_arrow_spin.png"
        imageOff: "../images/right_arrow_spin_off.png"
        opacity: parent.currentIndex == parent.count ? 0.6 : 1.0
        enabled: parent.currentIndex == parent.count ? false : true

        onButtonClick: {
            currentIndex += 1;
            if (currentIndex >= parent.count)
            {
                currentIndex = parent.count;
            }

            currentValue = items.get(currentIndex).value;
            currentText = items.get(currentIndex).text;
        }
    }

    Text{
        id: txtName
        height: parent.height
        text: currentText
        font.pointSize: 12
        font.family: "MV Boli"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.left: btnLeft.right
        anchors.right: btnRight.left

    }

    Component.onCompleted: {
        currentValue = items.get(currentIndex).value;
        currentText = items.get(currentIndex).text;
    }
}
