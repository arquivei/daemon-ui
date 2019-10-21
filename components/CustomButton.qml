import QtQuick 2.0
import QtQuick.Controls 2.5

Button {
    id: root

    property alias radius: buttonBackground.radius
    property alias fontSize: buttonContent.font.pixelSize

    background: Rectangle {
        id: buttonBackground
        color: '#000'
        radius: 20

        MouseArea {
            cursorShape: Qt.PointingHandCursor
            width: parent.width
            height: parent.height
            onClicked: { root.clicked() }
        }
    }
    contentItem: Text {
        id: buttonContent
        color: '#fff'
        text: root.text
        font.family: "Roboto Mono"
        font.weight: "Bold"
        horizontalAlignment: Text.AlignHCenter
    }
}
