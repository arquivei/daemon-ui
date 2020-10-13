import QtQuick 2.0
import '../../../constants/colors.js' as Colors
import '../../../components'

Item {
    id: root

    property string folder
    property bool hasDivider

    implicitHeight: childrenRect.height + 16
    implicitWidth: parent.width - 12

    signal remove();

    DsIconText {
        id: iconTextFolder

        icon: "qrc:/images/material-folder.svg"
        font.weight: 'Normal'
        text: folder
        textMaxLength: 60

        anchors {
            top: parent.top
            topMargin: 16
            left: parent.left
            leftMargin: 8
        }
    }

    ImageButton {
        id: deleteBtn

        source: 'qrc:/images/material-trash.svg'

        anchors {
            verticalCenter: iconTextFolder.verticalCenter
            right: parent.right
            rightMargin: 8
        }

        onClicked: remove();
    }


    Rectangle {
        id: divider

        height: hasDivider ? 1 : 0
        width: parent.width
        color: Colors.GRAYSCALE_300

        anchors {
            top: iconTextFolder.bottom
            topMargin: 15
        }
    }
}
