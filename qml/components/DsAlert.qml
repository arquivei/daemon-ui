import QtQuick 2.0
import '../../images'

Item {
    property string message

    id: root
    height: 40

    Rectangle {
        id: background
        color: '#F5F5F5'
        radius: 4

        anchors.fill: parent
    }

    Image {
        id: imageIcon
        source: "qrc:/images/alert-danger.svg"
        fillMode: Image.PreserveAspectFit
        anchors {
            left: parent.left
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
    }

    DsText {
        text: message
        color: '#E84545'
        fontSize: 12
        lineHeight: 16
        wrapMode: Text.WordWrap
        width: parent.width

        anchors {
            left: imageIcon.right
            right: root.right
            leftMargin: 10
            rightMargin: 10
            verticalCenter: imageIcon.verticalCenter
        }
    }
}
