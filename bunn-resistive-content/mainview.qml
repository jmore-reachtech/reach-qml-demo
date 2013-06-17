import QtQuick 1.1
import "../content/components"
import "../content/js/dataModel.js" as Db


Rectangle {
    width: 480
    height: 272
    id: mainView
    color: "#2D2D2D"

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

    Loader{
        id: loader
        objectName: "loader"
    }

    DataModel
    {
        id: items
    }

    CoffeeCarousel {
        id: imagecarousel1
        color: "Transparent"
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
        x: 32
        y: 204
        width: 66
        height: 56
        imageOn: "images/btnSettings.png"
        imageOff: "images/btnSettingsOff.png"
        onButtonClick: {
            setControlVisibility(false);
            loader.source = "settingsview.qml"
        }
    }

    ImageButton {
        id: btnRinse
        objectName: "btnRinse"
        x: 103
        y: 204
        width: 66
        height: 56
        imageOn: "images/btnRinse.png"
        imageOff: "images/btnRinseOff.png"
        imageDis: "images/btnRinseDis.png"
        onButtonClick: {
            setControlVisibility(false);
            loader.source = "rinseview.qml"
        }
    }

    ImageButton {
        id: btnBrew
        x: 173
        y: 204
        width: 66
        height: 56
        imageOn: "images/btnBrew.png"
        imageOff: "images/btnBrewOff.png"
        onButtonClick: {
            Db.currentIndex = imagecarousel1.currentIndex;
            setControlVisibility(false);
            loader.source = "brewview.qml"
        }
    }

    ImageButton {
        id: btnEdit
        x: 243
        y: 204
        width: 66
        height: 56
        imageOn: "images/btnEdit.png"
        imageOff: "images/btnEditOff.png"
        onButtonClick: {
            Db.currentIndex = imagecarousel1.currentIndex;
            setControlVisibility(false);
            loader.source = "recipeview.qml"
        }
    }

    ImageButton {
        id: btnAdd
        x: 313
        y: 204
        width: 66
        height: 56
        imageOn: "images/btnAdd.png"
        imageOff: "images/btnAddOff.png"
        onButtonClick: {
            setControlVisibility(false);
            loader.source = "addrecipeview.qml"
        }
    }

    ImageButton {
        id: btnQuit
        x: 383
        y: 204
        width: 66
        height: 56
        imageOn: "images/btnCancel.png"
        imageOff: "images/btnCancelOff.png"
        onButtonClick: {
            launcher.launchScript("main-content");
        }
    }

    function setControlVisibility(val){
        imagecarousel1.visible = val;
        btnSettings.visible = val;
        btnRinse.visible = val;
        btnBrew.visible = val;
        btnEdit.visible = val;
        btnAdd.visible = val;
        btnQuit.visible = val;
    }

    ScriptLauncher {
         id: launcher
    }

    Connections {
        target: loader.item
        onMessage: {
            loader.source = "";
            setControlVisibility(true);

            if (msg == "update")
            {
                Db.setSetting("currentIndex", Db.currentIndex);
                imagecarousel1.setCurrentIndex(Db.currentIndex);
            }
        }

    }

    Component.onCompleted: {
        Db.dataList = items;
        imagecarousel1.items = Db.dataList;

        //Open database connection
        Db.openDB();

        //Add the machine records
        if (Db.getRecipeCount() == 0)
        {
            Db.insertRecipe(1, "House Special", 8, 0.0, 10, 5, 45, 5, 10, 4, 7, 60, 200);
            Db.insertRecipe(1, "Decaf", 8, 0.0, 10, 5, 45, 5, 10, 4, 7, 60, 200);
            Db.insertRecipe(1, "Columbia", 8, 0.0, 10, 5, 45, 5, 10, 4, 7, 60, 200);
            Db.insertRecipe(1, "Costa Rica", 8, 0.0, 10, 5, 45, 5, 10, 4, 7, 60, 200);
            Db.insertRecipe(1, "Ethiopia", 8, 0.0, 10, 5, 45, 5, 10, 4, 7, 60, 200);
            Db.insertRecipe(1, "Kona", 8, 0.0, 10, 5, 45, 5, 10, 4, 7, 60, 200);
            Db.dataList.clear();
            Db.loadRecipes();

            Db.setSetting("currentIndex", 0);
        }
        else
        {
            //Load the table into the ListModel
            Db.dataList.clear();
            Db.loadRecipes();
        }

        var currentIndex = Db.getSetting("currentIndex");

        if (currentIndex != null &&  currentIndex >= 0)
        {
            imagecarousel1.setCurrentIndex(currentIndex);
            Db.currentIndex = currentIndex;
        }
        else
        {
            Db.currentIndex = 0;
            imagecarousel1.setCurrentIndex(0);
        }

    }

}
