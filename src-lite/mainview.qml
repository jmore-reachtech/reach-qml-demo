import QtQuick 1.1
import "components"

Item {
    id: mainView
    width: 480
    height: 272

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

