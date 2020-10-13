import QtQuick 2.12
import '../../../components'
import '../../../constants/texts.js' as Texts

Item {
    id: root

    property var folders
    property bool isBlocked

    signal updateFolderClicked()

    implicitHeight: childrenRect.height

    DsIconText {
        id: iconTextFolder
        icon: "qrc:/images/material-folder.svg"
        text: folders.length > 1 ? `${folders.length} pastas configuradas` : folders[0]
        textMaxLength: 60
    }

    DsLink {
        label: Texts.Config.CHANGE_FOLDER_BUTTON_LABEL
        isBlocked: root.isBlocked
        visible: folders.length === 1

        anchors {
            left: iconTextFolder.right
            leftMargin: 16
            verticalCenter: iconTextFolder.verticalCenter
        }

        onClick: root.updateFolderClicked()
    }
}
