import QtQuick 1.1

Item {
    id: mainView
    width: 800
    height: 480

    Loader{
        id: loader
    }

    Connections {
        target: loader.item
        onMessage: {
            loader.source = msg;
        }
    }

    Component.onCompleted: {
        loader.source = "mainmenu.qml";
    }
}

