import QtQuick 2.12
import '../constants/colors.js' as Colors

Item {
    property string message

    id: root
    height: 40

    Rectangle {
        id: background
        color: Colors.GRAYSCALE_100
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
        color: Colors.FEEDBACK_ERROR_DEFAULT
        fontSize: 12
        lineHeight: 16
        wrapMode: Text.WordWrap

        anchors {
            left: imageIcon.right
            right: root.right
            leftMargin: 10
            rightMargin: 10
            verticalCenter: imageIcon.verticalCenter
        }
    }
}
