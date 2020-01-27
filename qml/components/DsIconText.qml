import QtQuick 2.0

Item {
    property alias icon: imageIcon.source
    property alias text: textLabel.text

    id: root
    height: childrenRect.height
    width: childrenRect.width

    Image {
        id: imageIcon
        fillMode: Image.PreserveAspectFit

        anchors {
            left: parent.left
        }
    }

    DsText {
        id: textLabel
        color: '#737373'
        fontSize: 14
        font.weight: 'Bold'
        lineHeight: 22

        anchors {
            left: imageIcon.right
            leftMargin: 10
            verticalCenter: imageIcon.verticalCenter
        }
    }
}
