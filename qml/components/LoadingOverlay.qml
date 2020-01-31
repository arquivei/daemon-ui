import QtQuick 2.12
import '../constants/colors.js' as Colors

Item {
    id: root
    z: 100
    x: -1000
    y: -1000

    width: 2000
    height: 2000

    Rectangle {
        id: overlay
        color: Colors.PURE_WHITE
        opacity: 0.5
        visible: true

        anchors {
            fill: parent
        }

        MouseArea {
            hoverEnabled: true

            anchors {
                fill: parent
            }

            onClicked: {}
        }
    }
}
