import QtQuick 2.0
import '../../../constants/colors.js' as Colors
import '../../../constants/texts.js' as Texts
import '../../../components'

Item {
    id: root

    property var folder
    property bool hasDivider

    implicitHeight: childrenRect.height + 16
    implicitWidth: parent.width - 12

    signal remove();

    DsIconText {
        id: iconTextFolder

        icon: folder.code ? "qrc:/images/alert-error.svg" : "qrc:/images/material-folder.svg"
        font.weight: 'Normal'
        text: folder.path
        textMaxLength: 60

        anchors {
            top: parent.top
            topMargin: 16
            left: parent.left
            leftMargin: 8
        }

        CustomToolTip {
            id: tooltip
            visible: !!folder.code && parent.isHovered
            text: folder.code ? Texts.General.Tooltips.FolderErrors[folder.code] : ''
            contentWidth: 140
            y: parent.y - parent.height - tooltip.height
            x: root.x - 8
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
