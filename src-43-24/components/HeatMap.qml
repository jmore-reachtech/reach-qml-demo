import QtQuick 1.1
import "../../plugins"

Canvas {
    width: 256
    height: 300
    id: graph
    color: "transparent"
    property int centerX: width/2
    property int centerY: height/2
    //Number - the maximum number for intensity
    property int max: 20
    //Number - the minimum number for intensity
    property int min: 0
    //Number - Radius to draw the heat image
    property int radius: 20
    //Bool - Whether we calculate intensity
    property bool calculateIntensity: true
    //Number - this needs to be set if we do not calculate intensity (0 - 1 range)
    property real intensity: 0.2
    property alias model: data
    property variant ctx: graph.getContext("2d")
    property variant images: []

    ListModel{
        id: data
        ListElement
        {
            x: 10
            y: 20
            count: 18
        }
        ListElement
        {
            x: 25
            y : 50
            count : 14
        }
        ListElement
        {
            x: -50
            y : -10
            count : 10
        }
        ListElement
        {
            x: 12
            y: 22
            count : 16
        }
        ListElement
        {
            x: 1
            y: 2
            count : 4
        }
    }

    function draw()
    {
        ctx.fillStyle = "transparent";
        ctx.fillRect(0,0, graph.width, graph.height);

        //First we draw the dark intensity
        for (var i=0; i<model.count; i++)
        {
            var x = centerX + model.get(i).x
            var y = centerY + model.get(i).y

            if (calculateIntensity)
                intensity = ((model.get(i).count - min)/(max - min)).toFixed(1);
            else
                intensity = intensity.toFixed(1);

            if (intensity != 0)
            {
                var index  = intensity * 10;
                ctx.drawImage(images[index], x - (radius), y - (radius), radius*2, radius*2);
            }
        }

        ctx.createHeatMap(0,0, graph.width, graph.height, 0, 0);
    }

     Component.onCompleted:{
         var image1 = ctx.createImage("/application/src/images/0.1_small.png");
         var image2 = ctx.createImage("/application/src/images/0.2_small.png");
         var image3 = ctx.createImage("/application/src/images/0.3_small.png");
         var image4 = ctx.createImage("/application/src/images/0.4_small.png");
         var image5 = ctx.createImage("/application/src/images/0.5_small.png");
         var image6 = ctx.createImage("/application/src/images/0.6_small.png");
         var image7 = ctx.createImage("/application/src/images/0.7_small.png");
         var image8 = ctx.createImage("/application/src/images/0.8_small.png");
         var image9 = ctx.createImage("/application/src/images/0.9_small.png");
         var image10 = ctx.createImage("/application/src/images/1_small.png");

        images = [image1, image2, image3, image4, image5, image6, image7, image8, image9, image10];
        draw();
    }
}
