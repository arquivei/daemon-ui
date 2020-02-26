import QtQuick 2.12

Item {
    property bool isOnline: true

    id: root
    implicitHeight: statusIcon.height
    implicitWidth: childrenRect.width

    Item {
        id: statusIcon
        implicitWidth: successIcon.width
        implicitHeight: successIcon.height

        Image {
            id: successIcon
            source: "qrc:/images/alert-success.svg"
            visible: isOnline
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: errorIcon
            source: "qrc:/images/alert-danger.svg"
            visible: !isOnline
            fillMode: Image.PreserveAspectFit
        }
    }

    DsText {
        id: labelText
        text: `Status: <strong>${isOnline ? 'Online' : 'Offline'}</strong>`
        fontSize: 14
        lineHeight: 22
        anchors {
            left: statusIcon.right
            leftMargin: 6
            verticalCenter: statusIcon.verticalCenter
        }
    }
}
