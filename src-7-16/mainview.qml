import QtQuick 1.1
import "components"

Item {
    id: mainView
    width: 800
    height: 480

    Loader{
        id: loader
    }

    Beeper{
            id: beeper
    }

    Connections {
        target: loader.item
        onMessage: {
            beeper.beep();
            loader.source = msg;
        }
    }

    Component.onCompleted: {
        loader.source = "mainmenu.qml";
    }
}

