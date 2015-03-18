import QtQuick 1.1
import "components"

Rectangle {
    id: mainView
	color: "#2D2D2D"
    width: 480
    height: 272
    property int mainMenuY: 0
	property int page: 1

	Text{
        id: txtMessage
        anchors.centerIn:parent
        font.pixelSize: 22
        color: "Red"
        text: "Loading QML Application...Please Wait."
        visible: true
    }
	
	Connections {
        target: connection
        onReadyToSend: {
            txtMessage.visible = false;
            loader.source = "mainmenu.qml";
        }
    }
	
    Loader{
        id: loader
    }

    Beeper{
        id: beeper
    }

    Backlight{
        id: backLight
    }

    Connections {
        target: loader.item
        onMessage: {
            beeper.beep();
            loader.source = msg;            
        }
    }

	
    Component.onCompleted: {
        //Set beeper values
        var volume = settings.getValue("beeper_volume",50);
        var duration = settings.getValue("beeper_duration", 100);
        var freq = settings.getValue("beeper_frequency", 1000);

        beeper.setVolume(volume);
        beeper.setFrequency(freq);
        beeper.setDuration(duration);

        settings.setValue("beeper_volume", volume);
        settings.setValue("beeper_duration", duration);
        settings.setValue("beeper_frequency", freq);

        //Set backlight values
        var brightness = settings.getValue("backlight_brightness", 100);

        backLight.setBrightness(brightness);
        settings.setValue("backlight_enable", true);
        settings.setValue("backlight_brightness", brightness);

    }
}

