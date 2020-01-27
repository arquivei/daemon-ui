import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import '../../components'
import './partials'

Page {
    id: root

    property string uploadFolderPath

    signal selectUploadFolder(string folderPath)

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

    Item {
        id: content
        anchors {
            fill: parent
            topMargin: 25
            rightMargin: 32
            bottomMargin: 42
            leftMargin: 32
        }

        Header {
            id: header
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
            onClicked: console.log(uploadFolderDialog.folder)
        }
    }
}
