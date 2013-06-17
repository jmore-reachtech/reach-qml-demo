import QtQuick 1.1

Item {
    id: root
    width: 480
    height: 272

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
        loader.source = "vumeter.qml";
    }

}
