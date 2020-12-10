import QtQuick 2.12
import '../../../constants/colors.js' as Colors
import '../../../constants/texts.js' as Texts
import '../../../components'

Card {
    id: root

    property var folders
    property bool isBlocked: false

    QtObject {
        id: priv

        function displayFolderSelection() {
            if (folders && folders.length) {
                selectFolderLoader.setSource('./UpdateUploadFolder.qml', {
                    isBlocked: root.isBlocked,
                    folders: root.folders
                })
            } else {
                selectFolderLoader.setSource('../../../components/DsButton.qml', {
                    isBlocked: root.isBlocked,
                    text: Texts.Config.SELECT_FOLDER_BUTTON_LABEL
                })
            }
        }

        function getNumOfFolderErrors() {
            if (!folders) {
                return 0;
            }

            return folders.filter(folder => folder.code).length;
        }

        function getDescription() {
            const folderErrors = getNumOfFolderErrors();

            if (folderErrors === 1) {
                return '<strong>Atenção</strong>: verifique o erro da pasta abaixo. Se necessário, selecione uma nova pasta.'
            }

            if (folderErrors) {
                return `<strong>Atenção</strong>: ${folderErrors} das ${folders.length} pastas estão com erro de configuração.`
            }

            return Texts.Config.UPLOAD_SECTION_DESCRIPTION;
        }
    }

    signal selectFolderClicked()
    signal settingsClicked()

    Component.onCompleted: {
        priv.displayFolderSelection();
    }

    onFoldersChanged: {
        priv.displayFolderSelection();
    }

    onIsBlockedChanged: {
        priv.displayFolderSelection();
    }

    DsText {
        id: titleText
        text: Texts.General.UPLOAD_SECTION_TITLE
        fontSize: 20
        font.weight: 'Bold'
        lineHeight: 24
        color: Colors.BRAND_TERTIARY_DEFAULT

        anchors {
            top: parent.top
            topMargin: 16
            left: parent.left
            leftMargin: 16
        }
    }

    DsText {
        id: descriptionText
        text: priv.getDescription()
        fontSize: 12
        lineHeight: 18
        color: Colors.GRAYSCALE_500

        anchors {
            top: titleText.bottom
            topMargin: 2
            left: parent.left
            leftMargin: 16
        }
    }

    ImageButton {
        id: manageUploadBtn
        source: 'qrc:/images/material-settings.svg'
        visible: folders && folders.length
        isBlocked: root.isBlocked

        anchors {
            verticalCenter: titleText.verticalCenter
            right: parent.right
            rightMargin: 16
        }

        onClicked: settingsClicked()
    }

    Loader {
        id: selectFolderLoader

        anchors {
            bottom: parent.bottom
            bottomMargin: 24
            left: parent.left
            leftMargin: 16
        }

        Connections {
            id: selectFolderConnection

            target: folders && folders.length ? null : selectFolderLoader.item
            onClicked: root.selectFolderClicked()
        }

        Connections {
            id: updateFolderConnection

            target: folders && folders.length ? selectFolderLoader.item : null
            onUpdateFolderClicked: root.selectFolderClicked()
        }
    }
}
