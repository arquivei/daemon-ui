import QtQuick 2.12
import '../constants/colors.js' as Colors

Rectangle {
    property int type: DsOverlay.Types.Light

    enum Types {
        Light,
        Dark
    }

    property var colorByType: {
        "0": Colors.PURE_WHITE,
        "1": Colors.MODAL_OVERLAY
    }

    property var opacityByType: {
        "0": 0.5,
        "1": 1
    }

    id: root
    color: colorByType[type]
    opacity: opacityByType[type]
    visible: true

    x: -1000
    y: -1000

    width: 2000
    height: 2000

    MouseArea {
        hoverEnabled: true

        anchors {
            fill: parent
        }

        onClicked: {}
    }
}
