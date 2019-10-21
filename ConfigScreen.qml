import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13
import QtQuick.Dialogs 1.3 as Dialogs
import './components'

Page {
    id: root

    states: [
        State {
            name: "initial"
            PropertyChanges { target: selectFolderBtn; text: "Selecionar Pasta"; onClicked: {
                    selectUploadFolderDialog.open()
                } }
        },
        State {
            name: "configured"
            PropertyChanges { target: selectFolderBtn; text: "Editar"; onClicked: {
                    editFolderDialog.open()
                } }
        }
    ]

    Component.onCompleted: {
        root.state = app.uploadFolder ? "configured" : "initial"
    }

    Dialog {
        id: editFolderDialog
        title: "Tem certeza?"
        modal: true
        anchors.centerIn: parent
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

        onAccepted: { selectUploadFolderDialog.open() }
    }

    Dialog {
        id: logoutDialog
        title: "Tem certeza?"
        modal: true
        anchors.centerIn: parent
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

        onAccepted: { simulateLogout() }
    }

    Dialogs.FileDialog {
        id: selectUploadFolderDialog
        selectFolder : true
        title: "Escolha o diretório de upload"
        folder: shortcuts.home
        onAccepted: {
            simulateFolderSelection();
            stack.pop();
        }
    }

    Title {
        id: title
        text: "CONFIGURATION"

        width: parent.width
        anchors.top: parent.top
    }

    ImageButton {
        source: "images/back.svg"
        width: 24
        height: 24
        onClicked: {
            stack.pop()
        }
    }

    Column {
        width: parent.width
        anchors.bottom: parent.bottom
        spacing: 12

        FolderPath {
            id: folderPath
            label: 'Upload:'
            placeholder: 'Selecione uma pasta...'
            path: app.uploadFolder
        }

        CustomButton {
            id: selectFolderBtn
            fontSize: 12
            radius: 6
        }

        Divider {
            width: parent.width
        }

        CustomButton {
            id: logoutBtn
            text: 'Sair'
            fontSize: 12
            radius: 6
            onClicked: {
                logoutDialog.open()
            }
        }
    }

    function simulateLogout() {
        stack.pop(null)
    }

    function simulateFolderSelection() {
        app.uploadFolder = selectUploadFolderDialog.fileUrl
    }
}
