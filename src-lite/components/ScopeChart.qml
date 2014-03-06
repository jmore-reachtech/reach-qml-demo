import QtQuick 1.1
import "../../plugins"
import "../js/scopechart.js" as Data

Canvas{
    id: graph
    width: 400
    height: 200
    property bool scaleOverlay : false
    property bool scaleOverride : false
    //** Required if scaleOverride is true **
    //Number - The number of steps in a hard coded scale
    property int scaleSteps : 0
    //Number - The value jump in the hard coded scale
    property int scaleStepWidth : 0
    //Number - The scale starting value
    property int scaleStartValue : minYValue

    property string scaleLineColor : "rgba(0,0,0,1.0)"
    property int scaleLineWidth : 1
    property bool scaleShowLabels : true
    property string scaleLabel : "<%=value%>"
    property string  scaleFontFamily : "'Arial'"
    property int scaleFontSize : 12
    property string scaleFontStyle : "normal"
    property string scaleFontColor : "#666"
    property bool scaleShowGridLines : true
    property string scaleGridLineColor : "rgba(50,205,50,0.5)"
    property int scaleGridLineWidth : 1
    property bool pointDot : false
    property int pointDotRadius : 4
    property int pointDotStrokeWidth : 2
    property bool datasetStroke : true
    property int datasetStrokeWidth : 2
    //String - Color of the data stroke
    property string datasetStrokeColor : "#ffffff"
    property variant overlay
    property variant data
    property int maxYValue: 10
    property int minYValue: -10
    property string scaleBgColor: "#0000000"
    property string bgColor: "#EEEEEE"
    property int xAxisPosY: 0
    property int yAxisPosX: 0
    property int  xAxisLength: 0
    property int scaleHop: 0
    property real valueHop: 0
    property variant calculatedScale
    property int inComingValue
    property bool completed: false
    property int lastX
    property int lastY
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
    property int xPixels : 20;
    property bool blankOut: false
    property bool bezierCurve: false

    function draw()
    {
        ctx.fillStyle = bgColor;
        ctx.fillRect(0,0, width, height);

        var maxSize, labelHeight, valueBounds, labelTemplateString, widestXLabel, rotateLabels = 0;

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
                populateLabels(labelTemplateString, calculatedScale.labels,calculatedScale.steps, scaleStartValue, scaleStepWidth);
        }

        scaleHop = Math.floor(scaleHeight/calculatedScale.steps);
        calculateXAxisSize();


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
                ctx.font = scaleFontStyle + ";" + scaleFontSize+"px;" + scaleFontFamily;
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
            scale = Math.ceil(valueHop/4);
            //scale = 100.0;

            yAxisPosX = width-widestXLabel/2-xAxisLength;
            xAxisPosY = scaleHeight + scaleFontSize/2;
        }


        function drawScale(){
                //Fill background
                ctx.fillStyle = scaleBgColor;
                ctx.fillRect(yAxisPosX, xAxisPosY + scaleLineWidth, xAxisLength-(valueHop/scale), - (calculatedScale.steps * scaleHop)-scaleLineWidth);

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

                            ctx.fillText(data.labels[i], yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize+3);
                        }

                        ctx.beginPath();
                        ctx.moveTo(yAxisPosX + i * valueHop, xAxisPosY+3);

                        //Check i isnt 0, so we dont go over the Y axis twice.
                        if(scaleShowGridLines && i>0){                           
                            for (var k = 0; k < valueHop; k += valueHop/10)
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
                            ctx.lineTo(yAxisPosX + xAxisLength - 3, xAxisPosY - ((j+1) * scaleHop));
                            overlayCtx.beginPath();
                            overlayCtx.moveTo(yAxisPosX, xAxisPosY - ((j+1) * scaleHop));
                            overlayCtx.lineWidth = scaleGridLineWidth;
                            overlayCtx.strokeStyle = scaleGridLineColor;
                            overlayCtx.lineTo(yAxisPosX + xAxisLength - 3, xAxisPosY - ((j+1) * scaleHop))
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

    function drawLine()
    {
        ctx.strokeStyle = datasetStrokeColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();
        if (lastX === 0)
        {
            ctx.moveTo(yAxisPosX + scaleLineWidth, xAxisPosY - (calculateOffset(pointData.get(0).value,calculatedScale,scaleHop)))
        }
        else
        {
            ctx.moveTo(lastX, lastY);
        }

        lastX = xPos(pointData.count-1);
        lastY = yPos(pointData.count-1);

        if (bezierCurve)
        {
            var j = pointData.count-1
            if (j > 0)
                ctx.bezierCurveTo(xPos(j-0.5), yPos(j-1), xPos(j-0.5), yPos(j), xPos(j), yPos(j));
        }
        else
            ctx.lineTo(lastX,lastY);
        ctx.stroke();
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

    function yPos(iteration){
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

    ListModel { id: pointData }

    onInComingValueChanged: {
        if (completed && inComingValue != maxYValue+1)
        {
            if (pointData.count === 0)
            {
                lastX = 0;
                lastY = inComingValue;
                var d = {'value': inComingValue};
                pointData.append(d);
            }
            else if (pointData.count < scale)
            {
                var d = {'value': inComingValue};
                pointData.append(d);
                if (blankOut)
                {
                    var end = xAxisLength-valueHop + yAxisPosX;
                    var distance = xPixels;

                    if (xPos(pointData.count-1) + xPixels > end)
                        distance = end - xPos(pointData.count-1);

                    ctx.fillStyle = scaleBgColor;
                    ctx.fillRect(xPos(pointData.count-1), xAxisPosY, distance, - (calculatedScale.steps * scaleHop) - scaleLineWidth);
                    updateTime();
                }

                drawLine();

            }
            else{
                //We need to clear out the model
                var d = {'value': inComingValue};
                lastX = 0;
                lastY = pointData.get(scale-1).value;

                pointData.clear();
                pointData.append(d);

                //figure out what part of the past line to delete
                ctx.fillStyle = scaleBgColor;
                ctx.fillRect(xPos(lastX), xAxisPosY + scaleLineWidth, xPixels, - (calculatedScale.steps * scaleHop) - scaleLineWidth*2);
                blankOut = true;
                drawLine();
                updateTime();
            }

            //To force the onChange event in the future
            inComingValue = maxYValue + 1;
        }
    }

    Component.onCompleted: {
        ctx = getContext();

        if (scaleShowGridLines)
        {
            var canvasSrc = "import QtQuick 1.1; Canvas {id:overlay; z:100; color: \"transparent\"}";
            overlay = Qt.createQmlObject(canvasSrc, graph, "canvasObject");
            overlayCtx = overlay.getContext();
        }

        data = Data.lineData;
        //Update data
        data.labels[0] = minTime.toString();
        data.labels[1] = maxTime.toString();
        draw();
        valueHop = valueHop/scale;

        xPixels = parseInt(Math.floor(xPixels/valueHop) * valueHop);

        completed = true;

        minTime -= 1;
        maxTime -= 1;
        updateTime();
    }
}


