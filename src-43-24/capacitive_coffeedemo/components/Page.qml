import QtQuick 1.1

Rectangle {
    id: control
    width: 480
    height: 272
    color: "#666666"
    gradient: Gradient {
        GradientStop {position: 0.0; color: "#666666"}
        GradientStop {position: 1.0; color: "#EEEEEE"}
    }
    signal message(string msg)
}
