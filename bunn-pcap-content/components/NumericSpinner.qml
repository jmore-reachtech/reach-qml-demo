import QtQuick 1.1

 Image {
     property alias model: view.model
     property alias delegate: view.delegate
     property alias currentIndex: view.currentIndex
     property real itemHeight: 30
     property url selectorSource: "../images/spinner_select.png";

     source: "../images/spinner_bg.png"
     clip: true

     PathView {
         id: view
         anchors.fill: parent
         pathItemCount: height/itemHeight
         preferredHighlightBegin: 0.5
         preferredHighlightEnd: 0.5
         highlight: Image {source: selectorSource; width: view.width; height: itemHeight+4 }
         dragMargin: view.width/2

         path: Path {
             startX: view.width/2; startY: -itemHeight/2
             PathLine { x: view.width/2; y: view.pathItemCount*itemHeight + itemHeight }
         }
     }

     Keys.onDownPressed: view.incrementCurrentIndex()
     Keys.onUpPressed: view.decrementCurrentIndex()
 }
