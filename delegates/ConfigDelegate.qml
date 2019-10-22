import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml.Models 2.12
import QtQuick.Dialogs 1.3 as Dialogs
import '../components'

ItemDelegate {
    id: root

    property ObjectModel model
    property Item view

    property alias confirmLogoutDialog: confirmLogoutDialog
    property alias confirmEditFolderDialog: confirmEditFolderDialog
    property alias selectUploadFolderDialog: selectUploadFolderDialog

    states: [
        State {
            name: 'initial'
            PropertyChanges {
                target: selectFolderBtn;
                text: 'Selecionar Pasta';
                onClicked: view.openSelectFolder()
            }
        },
        State {
            name: 'configured'
            PropertyChanges {
                target: selectFolderBtn;
                text: 'Editar';
                onClicked: view.confirmEditFolder()
            }
        }
    ]

    Component.onCompleted: {
        model = parent.model
        view = parent
        root.state = app.uploadFolder ? 'configured' : 'initial'
    }

    Dialog {
        id: confirmEditFolderDialog
        title: 'Tem certeza?'
        modal: true
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

        anchors.centerIn: parent

        onAccepted: view.openSelectFolder()
    }

    Dialog {
        id: confirmLogoutDialog
        title: 'Tem certeza?'
        modal: true
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

        anchors.centerIn: parent

        onAccepted: view.logout()
    }

    Dialogs.FileDialog {
        id: selectUploadFolderDialog
        title: 'Escolha o diretório de upload'
        selectFolder : true
        folder: shortcuts.home

        onAccepted: view.selectFolder()
    }

    Title {
        id: title
        text: 'CONFIGURATION'

        width: parent.width
        anchors.top: parent.top
    }

    ImageButton {
        source: '../images/back.svg'

        width: 24
        height: 24

        onClicked: view.back()
    }

    Column {
        width: parent.width
        spacing: 12
        anchors.bottom: parent.bottom

        FolderPath {
            id: folderPath
            label: 'Upload:'
            placeholder: 'Selecione uma pasta...'
            path: model.uploadFolder
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

            onClicked: view.confirmLogout()
        }
    }
}
