import QtQuick 1.1
import "../components"
import "js/dataModel.js" as Db


Rectangle {
    width: 800
    height: 480
    id: root

    signal message(string msg)

    Image{
        source: "../images/bg.png"
        anchors.fill: parent
    }

    Text {
        id: textTitle
        x: 160
        y: 134
        width: 480
        color: "#ffffff"
        text: ""
        font.underline: false
        font.pixelSize: 18
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        style: Text.Normal
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
    }

    ProgressBar{
        id: progress
        x: 210
        y: 218
        width: 381
        height: 23

    }

    Timer{
        id: timer

        interval: 100; running: true; repeat: true
        onTriggered: {
            progress.value += 2;
            if (progress.value == progress.maximum)
            {
                timer.stop();
                root.message("resistive_coffeedemo/mainview.qml")
            }
        }
    }

    ImageButton {
        id: btnCancel
        x: 368
        y: 295
        width: 76
        height: 64
        text: ""
        imageUp: "../capacitive_coffeedemo/images/btnCancel.png"
        imageDown: "../capacitive_coffeedemo/images/btnCancelOff.png"
        onButtonClick: {
            if (typeof connection === "undefined")
                console.debug("brew=0");
            else
                connection.sendMessage("brew=0");
            root.message("resistive_coffeedemo/mainview.qml");
        }
    }

    Component.onCompleted: {
        if (Db.dataList.get(Db.currentIndex).volume == 8 || Db.dataList.get(Db.currentIndex).volume == 11)
            textTitle.text = "Brewing an " + Db.dataList.get(Db.currentIndex).volume + "oz cup of "
                             + Db.dataList.get(Db.currentIndex).recipeName + " please wait...";
        else
            textTitle.text = "Brewing a " + Db.dataList.get(Db.currentIndex).volume + "oz cup of "
                             + Db.dataList.get(Db.currentIndex).recipeName + " please wait...";

        //Send data to console
        var recipe = Db.dataList.get(Db.currentIndex);

        if (typeof connection === "undefined")
        {
            console.debug("&recipeid=" + recipe.recipeId + "&recipeName=" + encodeURIComponent(recipe.recipeName) +
                "&volume=" + encodeURIComponent(recipe.volume) + "&preWet=" + encodeURIComponent(recipe.preWet) +
                "&preInfusion=" + encodeURIComponent(recipe.preInfusion) + "&fillPause=" + encodeURIComponent(recipe.fillPause) +
                "&extractionTime=" + encodeURIComponent(recipe.extractionTime) + "&turbulenceOn=" + encodeURIComponent(recipe.turbulenceOn) +
                "&turbulenceOff=" + encodeURIComponent(recipe.turbulenceOff) + "&turbulencePower=" + encodeURIComponent(recipe.turbulencePower) +
                "&pressOutPower" + encodeURIComponent(recipe.pressOutPower) + "&pressOutTime=" + encodeURIComponent(recipe.pressOutTime) +
                "&temp=" +  encodeURIComponent(recipe.temp));
        }
        else
        {
            connection.sendMessage
                (
                    "brew="+recipe.recipeId + "," +
                    recipe.volume + "," +
                    recipe.preWet + "," +
                    recipe.preInfusion + "," +
                    recipe.fillPause + "," +
                    recipe.extractionTime + "," +
                    recipe.turbulenceOn + "," +
                    recipe.turbulenceOff + "," +
                    recipe.turbulencePower + "," +
                    recipe.pressOutPower + "," +
                    recipe.pressOutTime + "," +
                    recipe.temp
                 )

        }
    }
}

