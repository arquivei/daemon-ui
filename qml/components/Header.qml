import QtQuick 2.0

Item {
    id: root
    width: parent.width
    height: childrenRect.height

    Image {
        id: imageLogo
        source: "qrc:/images/arquivei-icon.svg"
        fillMode: Image.PreserveAspectFit

        anchors {
            top: menu.top
            topMargin: 7
            left: parent.left
        }
    }

    DsText {
        id: menu
        text: 'user@email.com.br'

        anchors {
            right: parent.right
        }
    }
}
