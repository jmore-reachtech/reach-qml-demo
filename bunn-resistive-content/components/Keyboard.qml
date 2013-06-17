import QtQuick 1.0

Rectangle {
    id: kb
    color: "#272727"
    property string rotateLeft: "\u2939"
    property string rotateRight: "\u2935"
    property string leftArrow: "\u2190"
    property string rightArrow: "\u2192"
    property string upperArrow: "\u2191"
    property string division : "\u00f7"
    property string multiplication : "\u00d7"
    property string squareRoot : "\u221a"
    property string plusminus : "\u00b1"
    border.color: "#272727"
    border.width: 4

    signal buttonPressed(string op)

    // span the parent's width
    anchors {
        left: parent.left
        right: parent.right
    }

    // A keyboard is attached the the bottom of an Item
    // and slides up when activated.
    // this item is called the surface
    property Item surface: parent

    // By default the keyboards height is at the bottom of the surface
    y: surface.height

}

