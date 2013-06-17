import QtQuick 1.0
import "components"

Rectangle {
    id: rootDial
    property int tempo: 80
    property int beat:  0
    property int count:  0
    property real beatsPerSecond: 1
    property int angleOffSet:  2
    property int max: 204
    property int min: 40
    property color beatColor: "red"
    property string countText

    width: 480; height:272
    clip: true
    color: "#666666"

    signal message(string msg)

    Image {
        id: name
        source: "images/met_interface.png"
        width:  372
        height:  204
        anchors.centerIn: parent

        MetronomeDial{
            id: metronomeDial
            width: 325; height: 158
            anchors.horizontalCenterOffset: -3
            angle: -56
            anchors.verticalCenterOffset: -1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            value: 0

            Text {
                id: txtTempoTitle
                x: 246
                y: 78
                text: "TEMPO"
                font.family: "Arial"
                font.pixelSize: 13
            }

            Text {
                id: txtBeatTitle
                x: 31
                y: 78
                text: "BEAT"
                font.family: "Arial"
                font.pixelSize: 13
            }

            Text {
                id: txtTempo
                x: 242
                y: 88
                width: 51
                height: 27
                text: tempo.toString()
                horizontalAlignment: Text.AlignRight
                font.family: "Arial"
                font.pixelSize: 27
            }

            Text {
                id: txtBeat
                x: 31
                y: 88
                width: 51
                height: 27
                text: beat.toString()
                horizontalAlignment: Text.AlignLeft
                font.family: "Arial"
                font.pixelSize: 27
            }

            Rectangle {
                id: leftBeatRectangle
                x: 31
                y: 24
                width: 40
                height: 40
                color: "#000000"
                radius: 20
                smooth: true
                visible: false;

                Text{
                    id:leftBeatText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: "white"
                    smooth: true;
                    font.family: "Arial"
                    font.pixelSize: 15
                    font.bold:  true
                    text: countText
                }
            }

            Rectangle {
                id: rightBeatRectangle
                x: 254
                y: 24
                width: 40
                height: 40
                color: "#000000"
                radius: 20
                smooth: true
                visible:  false;

                Text{
                    id:rightBeatText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: "white"
                    smooth: true;
                    font.family: "Arial"
                    font.pixelSize: 15
                    font.bold:  true
                    text: countText
                }
            }

            ImageButton {
                id: btnBeatPlus
                x: 52
                y: 117
                width: 19
                height: 19
                imageOn: "images/metpluson.png"
                imageOff: "images/metplusoff.png"
                color: "transparent"

                onButtonClick: {
                    timerTempo.stop();
                    metronomeDial.value = -56;
                    count = 0;
                    beat += 1;

                    if (beat > 4)
                        beat = 4;

                    beatsPerSecond = (60 / tempo * 1000 / 56);
                    timerTempo.interval = beatsPerSecond;
                    timerTempo.start();
                }
            }

            ImageButton {
                id: btnBeatMinus
                x: 31
                y: 117
                width: 19
                height: 19
                imageOn: "images/metminuson.png"
                imageOff: "images/metminusoff.png"
                color: "transparent"

                onButtonClick: {
                    timerTempo.stop();
                    metronomeDial.value = -56;
                    count = 0;
                    beat -= 1;
                    if (beat < 0)
                        beat = 0;

                    beatsPerSecond = (60 / tempo * 1000 / 56);
                    timerTempo.interval = beatsPerSecond;
                    timerTempo.start();
                }
            }

            ImageButton {
                id: btnTempoPlus
                x: 273
                y: 117
                width: 19
                height: 19
                imageOn: "images/metpluson.png"
                imageOff: "images/metplusoff.png"
                color: "transparent"

                onButtonClick: {
                    timerTempo.stop();
                    metronomeDial.value = -56;
                    tempo += 1;
                    if (tempo > max)
                        tempo = max;

                    beatsPerSecond = (60 / tempo * 1000 / 56);
                    timerTempo.interval = beatsPerSecond;
                    timerTempo.start();
                }
            }

            ImageButton {
                id: btnTempoMinus
                x: 252
                y: 117
                width: 19
                height: 19
                imageOn: "images/metminuson.png"
                imageOff: "images/metminusoff.png"
                color: "transparent"

                onButtonClick: {
                    timerTempo.stop();
                    metronomeDial.value = -56;
                    tempo -= 1;
                    if (tempo < min)
                        tempo = min;
                    beatsPerSecond = (60 / tempo * 1000 / 56);
                    timerTempo.interval = beatsPerSecond;
                    timerTempo.start();
                }
            }

        }



        }


        Timer{
            id:timerTempo
            interval: 1000; running: false; repeat: true
            onTriggered: {

                metronomeDial.value += angleOffSet;

                if (metronomeDial.value >= 56)
                {
                    angleOffSet = -2;
                    rightBeatRectangle.visible = true;
                    leftBeatRectangle.visible = false;
                    count += 1;

                    if ( (beat == 1 && count == 1) || (beat == 3 && count == 3) )
                        rightBeatRectangle.color = beatColor;
                    else
                        rightBeatRectangle.color = "black"

                    countText = count.toString();

                }
                else if (metronomeDial.value <= -56)
                {
                    angleOffSet = 2;
                    rightBeatRectangle.visible = false;
                    leftBeatRectangle.visible = true;
                    count += 1;

                    if ( (beat == 2 && count == 2) || (beat == 4 && count == 4) )
                        leftBeatRectangle.color = beatColor;
                    else
                        leftBeatRectangle.color = "black"

                    countText = count.toString();

                }



                if (count == 4)
                {
                    count = 0;
                }


            }
        }


        ImageButton {
            id: imagebutton1
            x: 4
            y: 188
            width:48
            height:48
            imageOff: "images/prev_down.png"
            imageOn: "images/prev_up.png"
            onButtonClick : rootDial.message("largedemo.qml");
        }

        Component.onCompleted: {
            tempo = 80;
            beatsPerSecond = (60 / tempo * 1000 / 56);
            metronomeDial.value = -56;
            timerTempo.interval = beatsPerSecond;
            timerTempo.start();

        }

}
