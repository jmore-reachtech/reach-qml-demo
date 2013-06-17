import QtQuick 1.1
import "components"

Item {
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
        loader.source = "dials.qml";
    }
}

