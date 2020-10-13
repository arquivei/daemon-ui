import QtQuick 2.12

Image {
    id: root

    property bool isBlocked: false

    signal clicked

    fillMode: Image.PreserveAspectFit

    MouseArea {
        id: mouseArea
        width: parent.width
        height: parent.height
        cursorShape: isBlocked ? Qt.ArrowCursor : Qt.PointingHandCursor
        onClicked: {
            if (!isBlocked) {
                 root.clicked()
            }
        }
    }
}
