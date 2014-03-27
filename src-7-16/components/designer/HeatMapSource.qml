import QtQuick 1.1
import "components"

HeatMap{
    id: heatMap
    width: 400
    height: 200
    max: 20
    min: 0
    radius: 20
    calculateIntensity: true
    intensity: 0
}
