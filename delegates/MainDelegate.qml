import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml.Models 2.12
import QtQuick.Dialogs 1.3 as Dialogs
import '../components'

ItemDelegate {
    id: root

    property ObjectModel model
    property Item view

    states: [
        State {
            name: 'syncing'
            PropertyChanges { target: syncStatus; state: 'syncing' }
        },
        State {
            name: 'success'
            PropertyChanges { target: syncStatus; state: 'success' }
        },
        State {
            name: 'error'
            PropertyChanges { target: syncStatus; state: 'error' }
        }
    ]

    Component.onCompleted: {
        model = parent.model
        view = parent
    }

    Title {
        id: title
        text: 'DAEMON'

        width: parent.width
        anchors.top: parent.top
    }

    ImageButton {
        source: '../images/external-link-symbol.svg'

        width: 18
        height: 18
        anchors.right: parent.right

        onClicked: view.openWeb()
    }

    Column {
        width: parent.width
        spacing: 12
        anchors.bottom: parent.bottom

        CustomButton {
            text: 'Configurações'
            fontSize: 12
            radius: 6

            onClicked: view.openConfig()
        }

        Divider {
            width: parent.width
        }

        FolderPath {
            id: folderPath
            label: 'Upload:'
            placeholder: 'Selecione uma pasta...'
            path: model.uploadFolder
        }

        SyncStatus {
            id: syncStatus
            successUrl: model.webSuccessUrl
            errorUrl: model.webErrorUrl
        }
    }
}
