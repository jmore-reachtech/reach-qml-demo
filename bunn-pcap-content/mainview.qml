import QtQuick 1.1
import "components"
import "js/dataModel.js" as Db

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

    DataModel
    {
        id: items
    }

    Component.onCompleted: {
        Db.dataList = items;

        //Open database connection
        Db.openDB();

        //Add the machine records
        if (Db.getRecipeCount() === 0)
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
            Db.currentIndex = currentIndex;
        }
        else
        {
            Db.currentIndex = 0;
        }

        loader.source = "coffeeview.qml";
    }
}

