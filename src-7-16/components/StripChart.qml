import QtQuick 1.1
import "../js/scopechart.js" as Data

Canvas{
    id: graph
    width: 400
    height: 200
    property bool scaleOverride : false
    //** Required if scaleOverride is true **
    //Number - The number of steps in a hard coded scale
    property int scaleSteps : 0
    //Number - The value jump in the hard coded scale
    property int scaleStepWidth : 0
    //Number - The scale starting value
    property int scaleStartValue : minYValue
    //String - Color of the scale line - x and y axis lines
    property string scaleLineColor : "rgba(0,0,0,1.0)"
    //Number - Pixel width of the scale line
    property int scaleLineWidth : 1
    //Boolean - Whether to show labels on the scale
    property bool scaleShowLabels : true
    //Interpolated JS string - can access value
    property string scaleLabel : "<%=value%>"
    //String - Scale label font declaration for the scale label
    property string  scaleFontFamily : "Arial"
    //Number - Scale label font size in pixels
    property int scaleFontSize : 12
    //String - Scale label font weight style
    property string scaleFontStyle : "normal"
    //String - Scale label font color
    property string scaleFontColor : "#666"
    //Boolean - Whether grid lines are shown across the chart
    property bool scaleShowGridLines : true
    //String - Color of the grid lines
    property string scaleGridLineColor : "rgba(50,205,50,0.5)"
    //Number - Width of the grid lines
    property int scaleGridLineWidth : 1
    //Number - Pixel width of dataset stroke
    property int datasetStrokeWidth : 2
    //String - Color of the line1
    property string line1PenColor : "#ffffff"
    //String - Color of the line2
    property string line2PenColor : ""
    //String - Color of the line3
    property string line3PenColor : ""
    //String - Color of the line2
    property string line4PenColor : ""
    //Number - maximum value for the amplitude
    property int maxYValue: 10
    //Number - minimum value for the amplitude
    property int minYValue: -10
    //String - background color of the scale
    property string scaleBgColor: "#0000000"
    //String - background color for the chart
    property string bgColor: "#EEEEEE"
    //String - background image for the chart
    property alias bgImage: imageBackground.source
    property int xAxisPosY: 0
    property int yAxisPosX: 0
    property int  xAxisLength: 0
    property int scaleHop: 0
    property real valueHop: 0
    property variant calculatedScale
    property int currentValue1
    property int currentValue2
    property int currentValue3
    property int currentValue4
    property variant pointData1
    property variant pointData2
    property variant pointData3
    property variant pointData4
    property int lastX1
    property int lastY1
    property int lastX2
    property int lastY2
    property int lastX3
    property int lastY3
    property int lastX4
    property int lastY4
    property bool completed: false
    property variant ctx
    property variant overlayCtx
    property int minXTime: 0
    property int minYTime: 0
    property int maxXTime: 0
    property int maxYTime: 0
    property int minTime: 0
    property int maxTime: 100
    property int scaleHeight: 0
    property int topY: 0
    property int scale: 100
    property variant overlay
    property variant data

    color: "transparent"

    function draw()
    {
        if (bgColor.length > 0)
        {
            ctx.fillStyle = bgColor;
            ctx.fillRect(0,0, width, height);
        }

        var calculatedScale, maxSize, labelHeight, valueBounds, labelTemplateString, widestXLabel, rotateLabels = 0;

        calculateDrawingSizes();

        valueBounds = getValueBounds();
        //Check and set the scale
        labelTemplateString = (scaleShowLabels)? scaleLabel : "";
        if (!scaleOverride){

                calculatedScale = calculateScale(scaleHeight,valueBounds.maxSteps,valueBounds.minSteps,valueBounds.maxValue,valueBounds.minValue,labelTemplateString);
        }
        else {
                calculatedScale = {
                        steps : scaleSteps,
                        stepValue : scaleStepWidth,
                        graphMin : scaleStartValue,
                        labels : []
                }
                populateLabels(labelTemplateString, calculatedScale.labels, calculatedScale.steps, scaleStartValue, scaleStepWidth);
        }

        scaleHop = Math.floor(scaleHeight/calculatedScale.steps);
        calculateXAxisSize();

        graph.calculatedScale = calculatedScale;

        drawScale();


        function calculateDrawingSizes(){
            maxSize = height;
            //Need to check the X axis first - measure the length of each text metric, and figure out if we need to rotate by 45 degrees.
            ctx.font = scaleFontStyle + ";" + scaleFontSize+"px;" + scaleFontFamily;
            widestXLabel = 1;
            for (var i=0; i<data.labels.length; i++){
                /* updated */
                var textLength = ctx.measureText(data.labels[i]);
                //If the text length is longer - make that equal to longest text!
                widestXLabel = (textLength > widestXLabel)? textLength : widestXLabel;
            }
            if (width/data.labels.length < widestXLabel){
                rotateLabels = 45;
                if (width/data.labels.length < Math.cos(rotateLabels) * widestXLabel){
                    rotateLabels = 90;
                    maxSize -= widestXLabel;
                }
                else{
                    maxSize -= Math.sin(rotateLabels) * widestXLabel;
                }
            }
            else{
                maxSize -= scaleFontSize;
            }

            //Add a little padding between the x line and the text
            maxSize -= 5;

            labelHeight = scaleFontSize;

            maxSize -= labelHeight;
            //Set 5 pixels greater than the font size to allow for a little padding from the X axis.

            scaleHeight = maxSize;
        };

        function getValueBounds() {
            var upperValue = maxYValue;
            var lowerValue = minYValue;

            var maxSteps = Math.floor((scaleHeight / (labelHeight*0.66)));
            var minSteps = Math.floor((scaleHeight / labelHeight*0.5));


            return {
                maxValue : upperValue,
                minValue : lowerValue,
                maxSteps : maxSteps,
                minSteps : minSteps
            }
        }

        function calculateScale(drawingHeight,maxSteps,minSteps,maxValue,minValue,labelTemplateString){
            var graphMin,graphMax,graphRange,stepValue,numberOfSteps,valueRange,rangeOrderOfMagnitude,decimalNum;

            valueRange = maxValue - minValue;

            rangeOrderOfMagnitude = calculateOrderOfMagnitude(valueRange);

            //graphMin = Math.floor(minValue / (1 * Math.pow(10, rangeOrderOfMagnitude))) * Math.pow(10, rangeOrderOfMagnitude);
            graphMin = minValue

            //graphMax = Math.ceil(maxValue / (1 * Math.pow(10, rangeOrderOfMagnitude))) * Math.pow(10, rangeOrderOfMagnitude);
            graphMax = maxValue

            graphRange = graphMax - graphMin;

            stepValue = Math.pow(10, rangeOrderOfMagnitude);

            numberOfSteps = Math.round(graphRange / stepValue);

            //Compare number of steps to the max and min for that size graph, and add in half steps if need be.
            while(numberOfSteps < minSteps || numberOfSteps > maxSteps) {
                if (numberOfSteps < minSteps){
                    stepValue /= 2;
                    numberOfSteps = Math.round(graphRange/stepValue);
                }
                else{
                    stepValue *=2;
                    numberOfSteps = Math.round(graphRange/stepValue);
                }
            };

            var labels = [];
            populateLabels(labelTemplateString, labels, numberOfSteps, graphMin, stepValue);

            return {
                steps : numberOfSteps,
                stepValue : stepValue,
                graphMin : graphMin,
                labels : labels

            }

            function calculateOrderOfMagnitude(val){
                return Math.floor(Math.log(val) / Math.LN10);
            }


        }

        //Populate an array of all the labels by interpolating the string.
        function populateLabels(labelTemplateString, labels, numberOfSteps, graphMin, stepValue) {
            if (labelTemplateString) {
                //Fix floating point errors by setting to fixed the on the same decimal as the stepValue.
                for (var i = 1; i < numberOfSteps + 1; i++) {
                    labels.push(tmpl(labelTemplateString, {value: (graphMin + (stepValue * i)).toFixed(getDecimalPlaces(stepValue))}));
                }
            }
        }


        function calculateXAxisSize(){
            var longestText = 1;
            //if we are showing the labels
            if (scaleShowLabels){
                ctx.font = scaleFontStyle + " " + scaleFontSize+"px " + scaleFontFamily;
                for (var i=0; i < calculatedScale.steps; i++)
                {
                    var measuredText = ctx.measureText(calculatedScale.labels[i]);
                    longestText = (measuredText > longestText)? measuredText : longestText;
                }

                //Add a little extra padding from the y axis
                longestText +=10;
            }

            xAxisLength = width - longestText - widestXLabel;

            valueHop = Math.floor(xAxisLength/(data.labels.length-1));
            scale = Math.ceil(valueHop/3);
            //scale = 100.0;

            yAxisPosX = width-widestXLabel/2-xAxisLength;
            xAxisPosY = scaleHeight + scaleFontSize/2;
        }


        function drawScale(){
                //Fill background
                ctx.fillStyle = scaleBgColor;
                //ctx.fillRect(yAxisPosX, xAxisPosY + scaleLineWidth, xAxisLength-(valueHop/scale), - (calculatedScale.steps * scaleHop)-scaleLineWidth);
                ctx.fillRect(yAxisPosX, xAxisPosY + scaleLineWidth, xAxisLength, - (calculatedScale.steps * scaleHop)-scaleLineWidth);

                if (scaleShowGridLines)
                {
                    overlay.height = graph.height;
                    overlay.width = graph.width;
                }

                topY = height - (height - xAxisPosY + (calculatedScale.steps * scaleHop)-scaleLineWidth);

                //X axis line
                ctx.lineWidth = scaleLineWidth;
                ctx.strokeStyle = scaleLineColor;
                ctx.beginPath();
                ctx.moveTo(width-widestXLabel/2,xAxisPosY);
                ctx.lineTo(width-(widestXLabel/2)-xAxisLength-3,xAxisPosY);
                ctx.stroke();

                if (rotateLabels > 0){
                        ctx.save();
                        ctx.textAlign = "right";
                }
                else{
                        ctx.textAlign = "center";
                }
                ctx.fillStyle = scaleFontColor;
                for (var i=0; i<data.labels.length; i++){
                        ctx.save();
                        if (rotateLabels > 0){
                                ctx.translate(yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize);
                                ctx.rotate(-(rotateLabels * (Math.PI/180)));
                                ctx.fillText(data.labels[i], 0,0);
                                ctx.restore();
                        }
                        else{
                            if (i === 0)
                            {
                                minXTime = yAxisPosX + i*valueHop;
                                minYTime = xAxisPosY + scaleFontSize+3;
                            }
                            else
                            {
                                maxXTime = yAxisPosX + i*valueHop;
                                maxYTime = xAxisPosY + scaleFontSize+3;
                            }

                            if (scaleShowLabels)
                                ctx.fillText(data.labels[i], yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize+3);
                        }

                        ctx.beginPath();
                        ctx.moveTo(yAxisPosX + i * valueHop, xAxisPosY+3);

                        //Check i isnt 0, so we dont go over the Y axis twice.
                        if(scaleShowGridLines && i>0){
                            for (var k = 0; k <= valueHop; k += valueHop/10)
                            {
                                overlayCtx.beginPath()
                                overlayCtx.moveTo(yAxisPosX + k, xAxisPosY+3);
                                overlayCtx.lineWidth = scaleGridLineWidth;
                                overlayCtx.strokeStyle = scaleGridLineColor;
                                overlayCtx.lineTo(yAxisPosX + k, topY);
                                overlayCtx.stroke();
                            }
                        }
                        else{
                                ctx.lineTo(yAxisPosX + i * valueHop, xAxisPosY+3);
                        }
                        ctx.stroke();
                }

                //Y axis
                ctx.lineWidth = scaleLineWidth;
                ctx.strokeStyle = scaleLineColor;
                ctx.beginPath();
                ctx.moveTo(yAxisPosX,xAxisPosY+5);
                ctx.lineTo(yAxisPosX,5);
                ctx.stroke();

                ctx.textAlign = "right";
                ctx.textBaseline = "middle";
                for (var j=0; j<calculatedScale.steps; j++){
                        ctx.beginPath();
                        ctx.moveTo(yAxisPosX-3,xAxisPosY - ((j+1) * scaleHop));
                        if (scaleShowGridLines){
                            ctx.lineWidth = scaleGridLineWidth;
                            ctx.strokeStyle = scaleBgColor;
                            //ctx.lineTo(yAxisPosX + xAxisLength - 3, xAxisPosY - ((j+1) * scaleHop));
                            ctx.lineTo(yAxisPosX + xAxisLength, xAxisPosY - ((j+1) * scaleHop));
                            overlayCtx.beginPath();
                            overlayCtx.moveTo(yAxisPosX, xAxisPosY - ((j+1) * scaleHop));
                            overlayCtx.lineWidth = scaleGridLineWidth;
                            overlayCtx.strokeStyle = scaleGridLineColor;
                            //overlayCtx.lineTo(yAxisPosX + xAxisLength - 3, xAxisPosY - ((j+1) * scaleHop))
                            overlayCtx.lineTo(yAxisPosX + xAxisLength, xAxisPosY - ((j+1) * scaleHop))
                            overlayCtx.stroke();
                        }
                        else{
                            ctx.lineTo(yAxisPosX-0.5,xAxisPosY - ((j+1) * scaleHop));
                        }

                        ctx.stroke();

                        if (scaleShowLabels){
                            ctx.fillText(calculatedScale.labels[j],yAxisPosX-8,xAxisPosY - ((j+1) * scaleHop) + scaleFontSize/2);
                        }
                }


        }

    /* end draw */
    }

    function transformLine()
    {
        ctx.strokeStyle = datasetStrokeColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();
        ctx.moveTo(xPos(0), yPos(0));

        //Draw Line
        for (var i=1; i < pointData.count; i++)
        {
            ctx.lineTo(xPos(i), yPos(i));
        }

        ctx.fillStyle = scaleBgColor;
        ctx.fillRect(yAxisPosX, xAxisPosY + scaleLineWidth, xAxisLength-valueHop, - (calculatedScale.steps * scaleHop)-scaleLineWidth);
        ctx.stroke();
    }

    function drawLine(lastX, lastY, linePenColor, pointData)
    {
        var x = 0;
        ctx.strokeStyle = linePenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();
        if (lastX === 0)
        {
            ctx.moveTo(yAxisPosX + scaleLineWidth, xAxisPosY - (calculateOffset(pointData.get(0).value,calculatedScale,scaleHop)))
        }
        else
        {
            ctx.moveTo(lastX, lastY);
            x = lastX;
        }

        lastX = xPos(pointData.count-1);
        lastY = yPos(pointData.count-1, pointData);

        //new
        if (x > 0)
            ctx.lineTo(x, lastY);

        ctx.lineTo(lastX,lastY);
        ctx.stroke();

        return {
            lastX: lastX,
            lastY: lastY
        }
    }


    function updateTime()
    {
        //Clear the rect
        ctx.fillStyle = bgColor;
        ctx.fillRect(0, xAxisPosY, width, xAxisPosY);

        ctx.lineWidth = scaleLineWidth;
        ctx.strokeStyle = scaleLineColor;

        minTime += 1;
        maxTime += 1;

        //Now write out new times
        ctx.textAlign = "center";
        ctx.fillStyle = scaleFontColor;
        ctx.fillText(minTime.toString(), minXTime, minYTime);
        ctx.fillText(maxTime.toString(), maxXTime-5, maxYTime);
    }

    function isNumber(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
    }

    function getDecimalPlaces (num){
            var numberOfDecimalPlaces;
            if (num%1!=0){
                    return num.toString().split(".")[1].length
            }
            else{
                    return 0;
            }

    }

    //Javascript micro templating by John Resig - source at http://ejohn.org/blog/javascript-micro-templating/
    property variant cache : []

    function tmpl(str, data){
        // Figure out if we're getting a template, or if we need to
        // load the template - and be sure to cache the result.
        var fn = !/\W/.test(str) ?
          cache[str] = cache[str] ||
            tmpl(document.getElementById(str).innerHTML) :

          // Generate a reusable function that will serve as a template
          // generator (and which will be cached).
          new Function("obj",
            "var p=[],print=function(){p.push.apply(p,arguments);};" +

            // Introduce the data as local variables using with(){}
            "with(obj){p.push('" +

            // Convert the template into pure JavaScript
            str
              .replace(/[\r\t\n]/g, " ")
              .split("<%").join("\t")
              .replace(/((^|%>)[^\t]*)'/g, "$1\r")
              .replace(/\t=(.*?)%>/g, "',$1,'")
              .split("\t").join("');")
              .split("%>").join("p.push('")
              .split("\r").join("\\'")
          + "');}return p.join('');");

        // Provide some basic currying to the user
        return data ? fn( data ) : fn;
      }


    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function xPos(iteration){
            return yAxisPosX + (valueHop * iteration);
    }

    function yPos(iteration, pointData){
            return xAxisPosY - calculateOffset(pointData.get(iteration).value,calculatedScale,scaleHop);
    }

    function capValue(valueToCap, maxValue, minValue){
            if (isNumber(maxValue) && valueToCap > maxValue)
                return maxValue;
            else if (isNumber(minValue) && valueToCap < minValue)
                return minValue;
            else
                return valueToCap;
    }

    function calculateOffset(val,calculatedScale,scaleHop){
        var outerValue = calculatedScale.steps * calculatedScale.stepValue;
        var adjustedValue = val - calculatedScale.graphMin;
        var scalingFactor = capValue(adjustedValue/outerValue,1,0);
        return (scaleHop*calculatedScale.steps) * scalingFactor;
    }

    onCurrentValue1Changed: {
        if (completed && currentValue1 != maxYValue+1)
        {
            if (pointData1.count === 0)
            {
                lastX1 = 0;
                lastY1 = currentValue1;
                var d = {'value': currentValue1};
                pointData1.append(d);
            }
            else if (pointData1.count < scale)
            {
                var d = {'value': currentValue1};
                pointData1.append(d);
                var draw = drawLine(lastX1, lastY1, line1PenColor, pointData1);
                lastX1 = draw.lastX;
                lastY1 = draw.lastY;
            }
            else{
                //We need to do some transforms
                //shift the pointData model
                pointData1.remove(0);
                var d = {'value': currentValue1};
                pointData1.append(d);
                if (line2PenColor.length == 0)
                {
                    ctx.drawWaveFormLine(yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData1.count-1) - xPos(1), calculatedScale.steps * scaleHop,  yAxisPosX + scaleLineWidth, topY - scaleLineWidth,
                                            scaleBgColor, xPos(pointData1.count-2), xAxisPosY + scaleLineWidth, valueHop + scaleLineWidth, - (calculatedScale.steps * scaleHop)-scaleLineWidth,
                                            line1PenColor, datasetStrokeWidth, xPos(pointData1.count-2), yPos(pointData1.count-2, pointData1)+0.5, xPos(pointData1.count-1), yPos(pointData1.count-1, pointData1)+0.5, true);
                    if (scaleShowLabels)
                        updateTime();
                }
            }

            //To force the onChange event in the future
            currentValue1 = maxYValue + 1;
        }
    }

    onCurrentValue2Changed: {
        if (completed && pointData2 && currentValue2 != maxYValue+1)
        {
            if (pointData2.count === 0)
            {
                lastX2 = 0;
                lastY2 = currentValue2;
                var d = {'value': currentValue2};
                pointData2.append(d);
            }
            else if (pointData2.count < scale)
            {
                var d = {'value': currentValue2};
                pointData2.append(d);
                var draw = drawLine(lastX2, lastY2, line2PenColor, pointData2);
                lastX2 = draw.lastX;
                lastY2 = draw.lastY;
            }
            else{
                //We need to do some transforms
                //shift the pointData model
                pointData2.remove(0);
                var d = {'value': currentValue2};
                pointData2.append(d);

                if (line3PenColor.length == 0)
                {
                    ctx.drawWaveFormLine(yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData1.count-1) - xPos(1), calculatedScale.steps * scaleHop,  yAxisPosX + scaleLineWidth, topY - scaleLineWidth,
                                            scaleBgColor, xPos(pointData1.count-2), xAxisPosY + scaleLineWidth, valueHop + scaleLineWidth, - (calculatedScale.steps * scaleHop)-scaleLineWidth, datasetStrokeWidth,
                                            line1PenColor, xPos(pointData1.count-2), yPos(pointData1.count-2, pointData1)+0.5, xPos(pointData1.count-1) , yPos(pointData1.count-1, pointData1)+0.5,
                                            line2PenColor, xPos(pointData2.count-2), yPos(pointData2.count-2, pointData2)+0.5, xPos(pointData2.count-1) , yPos(pointData2.count-1, pointData2)+0.5,
                                          true);
                    if (scaleShowLabels)
                        updateTime();
                }
            }

            //To force the onChange event in the future
            currentValue2 = maxYValue + 1;
        }

    }

    onCurrentValue3Changed: {
        if (completed && pointData3 && currentValue3 != maxYValue+1)
        {
            if (pointData3.count === 0)
            {
                lastX3 = 0;
                lastY3 = currentValue3;
                var d = {'value': currentValue3};
                pointData3.append(d);
            }
            else if (pointData3.count < scale)
            {
                var d = {'value': currentValue3};
                pointData3.append(d);
                var draw = drawLine(lastX3, lastY3, line3PenColor, pointData3);
                lastX3 = draw.lastX;
                lastY3 = draw.lastY;
            }
            else{
                //We need to do some transforms
                //shift the pointData model
                pointData3.remove(0);
                var d = {'value': currentValue3};
                pointData3.append(d);

                if (line4PenColor.length == 0)
                {
                    ctx.drawWaveFormLine(yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData1.count-1) - xPos(1), calculatedScale.steps * scaleHop,  yAxisPosX + scaleLineWidth, topY - scaleLineWidth,
                                            scaleBgColor, xPos(pointData1.count-2), xAxisPosY + scaleLineWidth, valueHop + scaleLineWidth, - (calculatedScale.steps * scaleHop)-scaleLineWidth, datasetStrokeWidth,
                                            line1PenColor, xPos(pointData1.count-2), yPos(pointData1.count-2, pointData1)+0.5, xPos(pointData1.count-1) , yPos(pointData1.count-1, pointData1)+0.5,
                                            line2PenColor, xPos(pointData2.count-2), yPos(pointData2.count-2, pointData2)+0.5, xPos(pointData2.count-1) , yPos(pointData2.count-1, pointData2)+0.5,
                                            line3PenColor, xPos(pointData3.count-2), yPos(pointData3.count-2, pointData3)+0.5, xPos(pointData3.count-1) , yPos(pointData3.count-1, pointData3)+0.5,
                                          true);
                    if (scaleShowLabels)
                        updateTime();
                }
            }

            //To force the onChange event in the future
            currentValue3 = maxYValue + 1;
        }

    }


    onCurrentValue4Changed: {
        if (completed && pointData4 && currentValue4 != maxYValue+1)
        {
            if (pointData4.count === 0)
            {
                lastX4 = 0;
                lastY4 = currentValue4;
                var d = {'value': currentValue4};
                pointData4.append(d);
            }
            else if (pointData4.count < scale)
            {
                var d = {'value': currentValue4};
                pointData4.append(d);
                var draw = drawLine(lastX4, lastY4, line4PenColor, pointData4);
                lastX4 = draw.lastX;
                lastY4 = draw.lastY;
            }
            else{
                //We need to do some transforms
                //shift the pointData model
                pointData4.remove(0);
                var d = {'value': currentValue4};
                pointData4.append(d);

                ctx.drawWaveFormLine(yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData1.count-1) - xPos(1), calculatedScale.steps * scaleHop,  yAxisPosX + scaleLineWidth, topY - scaleLineWidth,
                                        scaleBgColor, xPos(pointData1.count-2), xAxisPosY + scaleLineWidth, valueHop + scaleLineWidth, - (calculatedScale.steps * scaleHop)-scaleLineWidth, datasetStrokeWidth,
                                        line1PenColor, xPos(pointData1.count-2), yPos(pointData1.count-2, pointData1)+0.5, xPos(pointData1.count-1) , yPos(pointData1.count-1, pointData1)+0.5,
                                        line2PenColor, xPos(pointData2.count-2), yPos(pointData2.count-2, pointData2)+0.5, xPos(pointData2.count-1) , yPos(pointData2.count-1, pointData2)+0.5,
                                        line3PenColor, xPos(pointData3.count-2), yPos(pointData3.count-2, pointData3)+0.5, xPos(pointData3.count-1) , yPos(pointData3.count-1, pointData3)+0.5,
                                        line4PenColor, xPos(pointData4.count-2), yPos(pointData4.count-2, pointData4)+0.5, xPos(pointData4.count-1) , yPos(pointData4.count-1, pointData4)+0.5,
                                      true);
                if (scaleShowLabels)
                    updateTime();
            }

            //To force the onChange event in the future
            currentValue4 = maxYValue + 1;
        }

    }


    function getPixels()
    {
        return ctx.getImageData(yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData.count-1) - xPos(1), calculatedScale.steps * scaleHop);
    }

    Image{
        id: imageBackground
        visible: false
        width: graph.width
        height: graph.height
    }

    Component.onCompleted: {
        ctx = getContext();

        if (scaleShowGridLines)
        {
            var canvasSrc = "import QtQuick 1.1; Canvas {id:overlay; z:100; color:\"transparent\"}";
            overlay = Qt.createQmlObject(canvasSrc, graph, "canvasObject");
            overlayCtx = overlay.getContext();
        }

        data = Data.lineData;

        //Update data
        data.labels[0] = minTime.toString();
        data.labels[1] = maxTime.toString();

        var src = "import QtQuick 1.1; ListModel {}";
        pointData1 = Qt.createQmlObject(src, graph, "data1");

        if (line2PenColor.length > 0)
            pointData2 = Qt.createQmlObject(src, graph, "data2");

        if (line3PenColor.length > 0)
            pointData3 = Qt.createQmlObject(src, graph, "data3");

        if (line4PenColor.length > 0)
            pointData4 = Qt.createQmlObject(src, graph, "data4");

        if (imageBackground.source.toString().length > 0)
        {
            var imageSrc = "import QtQuick 1.1; Image{z: -10; width: graph.width; height: graph.height; source:\"" + imageBackground.source + "\"}";
            Qt.createQmlObject(imageSrc, graph, "bgImage");
        }

        draw();
        valueHop = valueHop/scale;
        completed = true;

        minTime -= 1;
        maxTime -= 1;
        if (scaleShowLabels)
            updateTime();
    }
}

