import QtQuick 1.1
import "components"
import "js/dataModel.js" as Db


Rectangle {
    width: 480
    height: 272
    id: mainView
    color: "#2D2D2D"
    signal message(string msg)

    gradient: Gradient {
        GradientStop {position: 0.0; color: "#666666"}
        GradientStop {position: 1.0; color: "#EEEEEE"}
    }

    //creating a appfont property that holds the font
    //loading using FontLoader
    property variant appfont: FontLoader {
        id: fontLoader
        source: "fonts/DejaVuSerif.ttf"
        onStatusChanged: {
            if (fontLoader.status == FontLoader.Ready)
                console.debug('Font Loaded')
        }
    }


    CoffeeCarousel {
        id: imagecarousel1
        x: 0
        y: 40
        width: 480
        height: 180

        onCurrentIndexChanged: {
            if (imagecarousel1.currentIndex >= 0)
            {
                Db.currentIndex = imagecarousel1.currentIndex;
                Db.setSetting("currentIndex", Db.currentIndex);
            }
        }
    }

    ImageButton {
        id: btnSettings
        x: 27
        y: 191
        width: 76
        height: 64
        imageOn: "images/btnSettings.png"
        imageOff: "images/btnSettingsOff.png"
        onButtonClick: {
            mainView.message("settingsview.qml");
        }
    }

    ImageButton {
        id: btnRinse
        objectName: "btnRinse"
        x: 98
        y: 191
        width: 76
        height: 64
        imageOn: "images/btnRinse.png"
        imageOff: "images/btnRinseOff.png"
        imageDis: "images/btnRinseDis.png"
        onButtonClick: {
            mainView.message("rinseview.qml");
        }
    }

    ImageButton {
        id: btnBrew
        x: 168
        y: 191
        width: 76
        height: 64
        imageOn: "images/btnBrew.png"
        imageOff: "images/btnBrewOff.png"
        onButtonClick: {
            Db.currentIndex = imagecarousel1.currentIndex;
            mainView.message("brewview.qml");
        }
    }

    ImageButton {
        id: btnEdit
        x: 238
        y: 191
        width: 76
        height: 64
        imageOn: "images/btnEdit.png"
        imageOff: "images/btnEditOff.png"
        onButtonClick: {
            Db.currentIndex = imagecarousel1.currentIndex;
            mainView.message("recipeview.qml");
        }
    }

    ImageButton {
        id: btnAdd
        x: 308
        y: 191
        width: 76
        height: 64
        imageOn: "images/btnAdd.png"
        imageOff: "images/btnAddOff.png"
        onButtonClick: {
            mainView.message("addrecipeview.qml");
        }
    }

    ImageButton {
        id: btnQuit
        x: 378
        y: 191
        width: 76
        height: 64
        imageOn: "images/btnCancel.png"
        imageOff: "images/btnCancelOff.png"
        onButtonClick: {
            launcher.launchScript("main-content");
        }
    }


    ScriptLauncher {
         id: launcher
    }

    Component.onCompleted: {
        imagecarousel1.items = Db.dataList;
        imagecarousel1.setCurrentIndex(Db.currentIndex);

    }

}
