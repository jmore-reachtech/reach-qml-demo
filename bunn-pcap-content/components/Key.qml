import QtQuick 1.0

    KeyButton {
        id: root

        property string character: ""
        property string alternative: ""
        property variant keyboard

        width: 80

        onClicked: {
            if (keyboard) {
                keyboard.keyEvent(op);
            }
        }

    }
