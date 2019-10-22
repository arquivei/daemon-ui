import QtQuick 2.0

Image {
    id: root
    signal clicked

    fillMode: Image.PreserveAspectFit

    MouseArea {
        id: mouseArea
        width: parent.width
        height: parent.height
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.clicked()
        }
    }
}