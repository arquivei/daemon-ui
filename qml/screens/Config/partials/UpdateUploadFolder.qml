import QtQuick 2.12
import '../../../components'
import '../../../constants/texts.js' as Texts

Item {
    id: root

    property var folders
    property bool isBlocked

    QtObject {
        id: priv

        function hasSingleFolderError() {
            return folders && folders.length === 1 && !!folders[0].code;
        }

        function hasFolderErrors() {
            return folders && folders.filter(folder => folder.code).length > 0;
        }
    }

    signal updateFolderClicked()

    implicitHeight: childrenRect.height

    DsIconText {
        id: iconTextFolder
        icon: priv.hasFolderErrors() ? "qrc:/images/alert-error.svg" : "qrc:/images/material-folder.svg"
        text: folders.length > 1 ? `${folders.length} pastas configuradas` : folders[0].path
        textMaxLength: 60

        CustomToolTip {
            id: tooltip
            visible: iconTextFolder.isHovered && priv.hasSingleFolderError();
            text: priv.hasSingleFolderError() ? Texts.General.Tooltips.FolderErrors[folders[0].code] : '';
            contentWidth: 140
            y: parent.y - parent.height - 10
            x: root.x - 8
        }
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
