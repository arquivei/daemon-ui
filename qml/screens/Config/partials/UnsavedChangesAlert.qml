import QtQuick 2.12
import '../../../constants/colors.js' as Colors
import '../../../components'

Item {
    id: root

    property string message

    height: 24
    implicitWidth: childrenRect.width + 2

    Image {
        id: imageIcon
        source: "qrc:/images/alert-danger.svg"
        fillMode: Image.PreserveAspectFit
        anchors {
            left: parent.left
            leftMargin: 2
            verticalCenter: parent.verticalCenter
        }
    }

    DsText {
        text: message
        color: Colors.GRAYSCALE_500
        fontSize: 14
        lineHeight: 21
        wrapMode: Text.WordWrap

        anchors {
            left: imageIcon.right
            leftMargin: 6
            verticalCenter: imageIcon.verticalCenter
        }
    }
}
