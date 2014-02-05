import QtQuick 1.1
import "../components"
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
        text: ""
        imageUp: "images/btnSettings.png"
        imageDown: "images/btnSettingsOff.png"

        onButtonPress: {
            mainView.message("capacitive_coffeedemo/settingsview.qml");
        }
    }

    ImageButton {
        id: btnRinse
        objectName: "btnRinse"
        x: 98
        y: 191
        text: ""
        width: 76
        height: 64
        imageUp: "images/btnRinse.png"
        imageDown: "images/btnRinseOff.png"

        onButtonPress: {
            mainView.message("capacitive_coffeedemo/rinseview.qml");
        }
    }

    ImageButton {
        id: btnBrew
        x: 168
        y: 191
        text: ""
        width: 76
        height: 64
        imageUp: "images/btnBrew.png"
        imageDown: "images/btnBrewOff.png"

        onButtonPress: {
            Db.currentIndex = imagecarousel1.currentIndex;
            mainView.message("capacitive_coffeedemo/brewview.qml");
        }
    }

    ImageButton {
        id: btnEdit
        x: 238
        y: 191
        width: 76
        height: 64
        text: ""
        imageUp: "images/btnEdit.png"
        imageDown: "images/btnEditOff.png"
        onButtonPress: {
            Db.currentIndex = imagecarousel1.currentIndex;
            mainView.message("capacitive_coffeedemo/recipeview.qml");
        }
    }

    ImageButton {
        id: btnAdd
        x: 308
        y: 191
        width: 76
        height: 64
        text: ""
        imageUp: "images/btnAdd.png"
        imageDown: "images/btnAddOff.png"
        onButtonPress: {
            mainView.message("capacitive_coffeedemo/addrecipeview.qml");
        }
    }

    ImageButton {
        id: btnQuit
        x: 378
        y: 191
        width: 76
        height: 64
        text: ""
        imageUp: "images/btnCancel.png"
        imageDown: "images/btnCancelOff.png"
        onButtonPress: {
            mainView.message("../src/mainmenu.qml");
        }
    }

    DataModel
    {
        id: items
    }

    Component.onCompleted: {
        Db.dataList = items;
        //Open database connection
        Db.openDB();

        //Add the machine records if need be
        if (parseInt(Db.getRecipeCount()) === 0)
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
            //Load the table
            Db.dataList.clear();
            Db.loadRecipes();
        }

        var currentIndex = parseInt(Db.getSetting("currentIndex"));

        if (currentIndex && currentIndex >= 0)
        {
            Db.currentIndex = currentIndex;
        }
        else
        {
            Db.currentIndex = 0;
        }

        imagecarousel1.items = Db.dataList;
        imagecarousel1.setCurrentIndex(Db.currentIndex);
    }

}
