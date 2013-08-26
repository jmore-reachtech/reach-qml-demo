import QtQuick 1.1
import "components"
import "js/dataModel.js" as Db


Rectangle {
    width: 480
    height: 272
    id: root
    objectName: "root"
    color: "#2D2D2D"
    property int m_Index: 0

    onM_IndexChanged: {
        imagecarousel1.setCurrentIndex(m_Index);
    }

    signal message(string msg)

    gradient: Gradient {
        GradientStop {position: 0.0; color: "#666666"}
        GradientStop {position: 1.0; color: "#EEEEEE"}
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
            root.message("settingsview.qml");
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
            root.message("rinseview.qml");
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
            root.message("brewview.qml");
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
            root.message("recipeview.qml");
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
            root.message("addrecipeview.qml");
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
