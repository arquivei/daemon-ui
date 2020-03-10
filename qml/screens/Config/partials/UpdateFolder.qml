import QtQuick 2.12
import '../../../components'
import '../../../constants/texts.js' as Texts

Item {
    width: root.width

    DsIconText {
        id: iconTextFolder
        icon: "qrc:/images/material-folder.svg"
        text: folderPath
        textMaxLength: 60
    }

    DsLink {
        label: Texts.Config.CHANGE_FOLDER_BUTTON_LABEL
        isBlocked: root.isBlocked

        anchors {
            left: iconTextFolder.right
            leftMargin: 16
            verticalCenter: iconTextFolder.verticalCenter
        }

        onClick: openDialog()
    }
}
