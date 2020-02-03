import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../components'
import './partials'

Page {
    id: root

    property string uploadFolderPath

    signal selectUploadFolder(string folderPath)
    signal logout()

    function openUploadFolderDialog() {
        uploadFolderDialog.open();
    }

    function setFolderPath(folderPath) {
        uploadFolderPath = folderPath;
    }

    FileDialog {
        id: uploadFolderDialog
        title: 'Escolha o diretório de upload'
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            selectUploadFolder(uploadFolderDialog.fileUrl);
        }
    }

    DsModal {
        id: saveModal
        title: 'Download de Documentos'
        showSecondaryButton: true
        text: 'Você ainda não possui o módulo de serviço de Download de Documentos. Deseja continuar sem contratar o serviço?'
        secondaryActionLabel: 'Contratar'
        primaryActionLabel: 'Continuar'
        onPrimaryAction: saveModal.close()
        onSecondaryAction: saveModal.close()
    }

    Item {
        id: content

        anchors {
            fill: parent
            topMargin: 24
            rightMargin: 32
            bottomMargin: 42
            leftMargin: 32
        }

        Header {
            id: header
            onLogout: {
                root.logout();
            }
        }

        DsText {
            id: title
            text: 'Configurar integração'
            fontSize: 24
            font.weight: 'Bold'
            lineHeight: 32
            color: '#1D416E'

            anchors {
                top: header.bottom
                topMargin: 32
            }
        }

        UploadSection {
            id: uploadSection
            folderPath: uploadFolderPath

            anchors {
                top: title.bottom
                topMargin: 16
            }

            onOpenDialog: openUploadFolderDialog()
        }

        DownloadSection {
            id: downloadSection

            anchors {
                top: uploadSection.bottom
                topMargin: 8
            }
        }

        DsButton {
            id: btnTour
            text: 'Tour do App'
            type: DsButton.Types.Inline
            anchors {
                left: parent.left
                top: downloadSection.bottom
                topMargin: 16
            }
        }

        DsButton {
            id: btnSave
            text: 'Salvar'
            type: DsButton.Types.Special
            enabled: uploadFolderPath ? true : false
            anchors {
                right: parent.right
                top: downloadSection.bottom
                topMargin: 16
            }
            onClicked: saveModal.open()
        }
    }
}
