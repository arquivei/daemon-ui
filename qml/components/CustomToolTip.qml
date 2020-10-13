import QtQuick 2.12
import QtQuick.Controls 2.12
import '../constants/colors.js' as Colors

ToolTip {
    id: root

    verticalPadding: 3
    leftPadding: 8
    rightPadding: 8

    contentItem: DsText {
        text: root.text
        color: Colors.PURE_WHITE
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }

    background: Rectangle {
        color: Colors.GRAYSCALE_600
        radius: 4
    }

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
    }

    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 }
    }
}
