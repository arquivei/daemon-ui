import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../helpers/validator.js' as Validator
import '../../helpers/text-helper.js' as TextHelper
import '../../constants/texts.js' as Texts
import '../../components'
import './partials'

Page {
    id: root

    property string downloadFolder
    property var uploadFolders: []

    QtObject {
        id: priv

        property string folderToRemove
        property bool hasUploadConfigChanged: false
    }

    signal addUploadFolder(string folder)
    signal confirmSelection(var folders)
    signal returnToConfig()

    function appendToUploadFolderList(folder) {
        priv.hasUploadConfigChanged = true;
        uploadFolders = [...uploadFolders, folder]
    }

    function openConfirmRemoval(folderPath) {
        const truncatedFolderPath = TextHelper.truncate(folderPath, 52);
        removeConfirmationModal.title = Texts.ManageUpload.Modals.RemoveUploadFolder.TITLE
        removeConfirmationModal.text = TextHelper.fillStr(Texts.ManageUpload.Modals.RemoveUploadFolder.DESCRIPTION, truncatedFolderPath);
        removeConfirmationModal.open();
    }

    function openErrorModal(title, message) {
        errorModal.title = title;
        errorModal.text = message;
        errorModal.open();
    }

    FileDialog {
        id: addFolderDialog
        title: 'Adicionar Pasta de Upload'
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            const url = addFolderDialog.fileUrl.toString();

            if (Validator.isSameFolder(url, downloadFolder)) {
                const { TITLE, DESCRIPTION } = Texts.ManageUpload.Modals.SameAsDownloadFolderError;
                openErrorModal(TITLE, DESCRIPTION)
                return;
            }

            if (uploadFolders.some(folder => Validator.isSameFolder(url, folder))) {
                const { TITLE, DESCRIPTION } = Texts.ManageUpload.Modals.UploadFolderAlreadySelectedError;
                openErrorModal(TITLE, DESCRIPTION)
                return;
            }

            addUploadFolder(url);
        }
    }

    DsModal {
        id: errorModal
        primaryActionLabel: 'Entendi'
        onPrimaryAction: {
            errorModal.close();
        }
    }

    DsModal {
        id: removeConfirmationModal
        showSecondaryButton: true
        primaryActionLabel: 'Sim'
        secondaryActionLabel: 'Não'
        onSecondaryAction: {
            priv.folderToRemove = null
            removeConfirmationModal.close();
        }
        onPrimaryAction: {
            uploadFolders = uploadFolders.filter(folder => folder !== priv.folderToRemove)
            priv.folderToRemove = null;
            priv.hasUploadConfigChanged = true;
            removeConfirmationModal.close();
        }
    }

    DsModal {
        id: uploadConfigChangedAlertModal
        title: Texts.ManageUpload.Modals.UploadConfigChanged.TITLE
        showSecondaryButton: true
        text: Texts.ManageUpload.Modals.UploadConfigChanged.DESCRIPTION
        secondaryActionLabel: Texts.ManageUpload.Modals.UploadConfigChanged.SECONDARY
        primaryActionLabel: Texts.ManageUpload.Modals.UploadConfigChanged.PRIMARY
        onPrimaryAction: {
            uploadConfigChangedAlertModal.close();
            returnToConfig();
        }
        onSecondaryAction: uploadConfigChangedAlertModal.close()
    }

    Item {
        id: content

        anchors {
            fill: parent
            margins: 32
            bottomMargin: 40
        }

        ManageUploadHeader {
            id: header

            anchors {
                top: parent.top
            }

            selectedFoldersLength: uploadFolders.length
            onAddFolder: addFolderDialog.open()
        }

        UploadFoldersList {
            id: folderList

            items: uploadFolders.map(item => ({ path: item }))

            anchors {
                top: header.bottom
                topMargin: 24
            }

            onRemove: {
                priv.folderToRemove = path
                openConfirmRemoval(path)
            }
        }

        DsButton {
            id: btnClose

            text: 'Fechar'
            type: DsButton.Types.Inline

            onClicked: {
                if (priv.hasUploadConfigChanged) {
                    uploadConfigChangedAlertModal.open()
                    return;
                }
                returnToConfig();
            }

            anchors {
                left: content.left
                bottom: content.bottom
            }
        }

        DsButton {
            id: btnConfirmSelection

            text: 'Confirmar'
            enabled: priv.hasUploadConfigChanged

            anchors {
                right: content.right
                bottom: content.bottom
            }

            onClicked: confirmSelection(uploadFolders)
        }
    }
}
