import QtQuick 2.12
import '../constants/colors.js' as Colors

Item {
    property bool isBlocked: false
    property Rectangle tourRef: tourBox

    id: root
    implicitHeight: children[1].height
    implicitWidth: children[1].width

    Component.onCompleted: {
        const Child = children[1];
        tourBox.implicitHeight = Child.height + 16
        tourBox.implicitWidth = Child.width + 16
        tourBox.anchors.verticalCenter = Child.verticalCenter
        tourBox.anchors.horizontalCenter = Child.horizontalCenter
    }

    Rectangle {
        id: tourBox
        radius: 8
        color: Colors.PURE_WHITE
    }
}
