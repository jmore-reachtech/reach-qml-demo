import QtQuick 1.1


Rectangle
{
    id: view
    height: 180
    width: 180
    color: "transparent"
    property real degreeAngle : 360.0/repeater.model.count
    property real digitAngle : degreeAngle/57.2957795
    property real angleOffSet:  90.0 + degreeAngle/2 //We rotate the needle around the positive x axis in a downward position
    property real value
    //Use to value to set the value directly without user intervention
    property real setValue
    property real index
    property alias model : repeater.model
    property alias imageBase: imgDialBase.source
    property alias imageNeedle: dialer.source
    property alias mouseAreaHeight: mouseArea.height
    property alias mouseAreaWidth: mouseArea.width
    property bool firstLoad: true
    property bool add: false;
    property bool remove: false;
    property alias imageBaseWidth: imgDialBase.width
    property alias imageBaseHeight: imgDialBase.height

    onSetValueChanged: {
        var valueScale = 0;
        var indexScale = 0;

        for (var i = 0; i < repeater.model.count-1; i++)
        {
            if (setValue >= repeater.model.get(i).value && setValue <= repeater.model.get(i+1).value)
            {
                valueScale = (setValue - repeater.model.get(i).value)/(repeater.model.get(i+1).value - repeater.model.get(i).value);
                indexScale = repeater.model.get(i).index + valueScale;
                //now that we know the index we can rotate the needle
                value = setValue;
                dialer.rotation = angleOffSet + indexScale * degreeAngle;
                break;
            }

        }
    }

    onIndexChanged: {
        //calculate the value using extrapolation
        //console.debug(index)
        var valueScale = 0;
        var indexScale = 0;
        for (var i = 0; i < repeater.model.count-1; i++)
        {
            if (index >= repeater.model.get(i).index && index <= repeater.model.get(i+1).index)
            {
                valueScale = (repeater.model.get(i+1).value - repeater.model.get(i).value);
                indexScale = index - repeater.model.get(i).index;

                value = valueScale * indexScale + repeater.model.get(i).value;
                break;
            }

        }

    }

    onAngleOffSetChanged: {
        if (angleOffSet > 90)
        {
            var count = repeater.model.count-1;
            if (remove)
                count += 1;

            for (var i = 0; i < count; i++)
            {
                try
                {
                    numbers.children[i].rotation = -angleOffSet;
                }
                catch (err)
                {
                    //console.debug(i);
                }
            }

            numbers.rotation = angleOffSet;
            dialer.rotation = angleOffSet;
            add = false;
            remove = false;
        }
    }

    /* List element for the control */
    ListModel{
        id: listModel
        ListElement{
            index: 0
            value: 0
        }
        ListElement{
            index: 1
            value: 1
        }
        ListElement{
            index: 2
            value: 2
        }
        ListElement{
            index: 3
            value: 3
        }
        ListElement{
            index: 4
            value: 4
        }
        ListElement{
            index: 5
            value: 5
        }


    }


    Image {
        id: imgDialBase
        source: "../images/dialbase.png"
        anchors.centerIn: parent

    }

    Image {
        id: dialer
        source: "../images/dialneedle.png"
        smooth: true
        anchors.centerIn: parent

    }

    Rectangle{
        id: recValue
        height: 40
        radius: 9
        border.width: 2
        border.color: "#000000"
        width: 40
        visible: mouseArea.pressed

        Text {
            id: txtValue
            anchors.centerIn: parent
            text: view.value.toFixed(1).toString();
            font.pixelSize: 14
        }

    }

    MouseArea {
        id: mouseArea
        height: 77
        width: 77
        anchors.centerIn: parent

        onPositionChanged: {
             dialer.rotation = getEventAngle(mouse);
        }
        onReleased: {
             dialer.rotation = getEventAngle(mouse);
        }
        onPressed: {
            //dialer.rotation += 40;
            dialer.rotation = getEventAngle(mouse);
        }
    }

    /**************************************************************/
    /* This section will draw the numbers around the outer circle.*/
    /**************************************************************/
    Rectangle {
        id: numbers
        anchors.fill: parent
        color: "transparent"

        Repeater {
            id: repeater
            model: listModel
            delegate:
                Rectangle {
                width: 30
                height: 30
                color: "transparent"
                x: view.width / 2 + (imgDialBase.width * 0.60) * Math.cos((-index) * digitAngle) - 15
                y: view.height / 2 - (imgDialBase.width * 0.60) * Math.sin((-index) * digitAngle) - 15

                Text {
                    color: "white"
                    font.pointSize:9
                    anchors.centerIn: parent
                    font.bold: false
                    text: value
                    style: Text.Sunken
                }
                Component.onCompleted: {
                    rotation = -angleOffSet;
                }
            }

          anchors.centerIn: parent
      }

}


    function getEventAngle(event)
    {
        var angle = Math.atan2(event.y - 46, event.x - 46);

        recValue.x = event.x + 40;
        recValue.y = event.y + 80;

        if(angle < 0)
            angle += 2 * Math.PI;

        //1 radian = 57.2957795 degrees
        var angleCalc = angle * 57.2957795 - angleOffSet;

        if (angleCalc < 0)
            angleCalc = angleCalc += 360.0;

        view.index = angleCalc / degreeAngle;
        return (angle * 57.2957795);
    }


    Component.onCompleted : {
        numbers.rotation = angleOffSet;
        //Set the angle to what value is first assigned
        dialer.rotation = angleOffSet;
        console.debug(angleOffSet)
        firstLoad = false;
    }

}
