import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13
import './components'

Page {
    id: root

    property string webUrl: 'https://app.arquivei.com.br'
    property string errorUrl: 'https://br.bing.com'
    property string successUrl: 'https://www.google.com'

    states: [
        State {
            name: "syncing"
            PropertyChanges { target: syncStatus; state: 'syncing' }
        },
        State {
            name: "success"
            PropertyChanges { target: syncStatus; state: 'success' }
        },
        State {
            name: "error"
            PropertyChanges { target: syncStatus; state: 'error' }
        }
    ]

    StackView.onStatusChanged: {
        if (StackView.status === StackView.Activating) {
            root.state = 'syncing'

            simulateAsyncCall(function () {
                root.state = 'success';
            }, function () {
                root.state = 'error';
            }, 3000)
        }
    }

    Title {
        id: title
        text: "DAEMON"

        width: parent.width
        anchors.top: parent.top
    }

    ImageButton {
        source: "images/external-link-symbol.svg"
        width: 18
        height: 18
        anchors.right: parent.right
        onClicked: {
            Qt.openUrlExternally(webUrl)
        }
    }

    Column {
        width: parent.width
        anchors.bottom: parent.bottom
        spacing: 12

        CustomButton {
            text: 'Configurações'
            fontSize: 12
            radius: 6

            onClicked: {
                stack.push("ConfigScreen.qml")
            }
        }

        Divider {
            width: parent.width
        }

        FolderPath {
            id: folderPath
            label: 'Upload:'
            placeholder: 'Selecione uma pasta ...'
            path: app.uploadFolder
        }

        SyncStatus {
            id: syncStatus
            successUrl: root.successUrl
            errorUrl: root.errorUrl
        }
    }

    function simulateAsyncCall(successCB, errorCB, delay) {
        function Timer() {
            return Qt.createQmlObject("import QtQuick 2.0; Timer {}", root);
        }

        var callback = !app.uploadFolder.includes('Download') ? successCB : errorCB;

        var timer = new Timer();
        timer.interval = delay;
        timer.repeat = false;
        timer.triggered.connect(callback);
        timer.start();
    }
}
