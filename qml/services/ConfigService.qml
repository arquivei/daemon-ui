import QtQuick 2.12

Item {
    id: root

    signal setUploadFolderSuccess(string folderPath);
    signal setUploadFolderError(string code);

    function isConfigured() {
        return QmlBridge.uploadFolderPath ? true : false;
    }

    function setUploadFolder(folderPath) {
        QmlBridge.setUploadFolder(folderPath);
    }

    function getUploadFolder() {
        return QmlBridge.uploadFolderPath;
    }

    Connections {
        target: QmlBridge
        onSetUploadFolderSignal: {
            if (success) {
                root.setUploadFolderSuccess(folderPath);
            } else {
                root.setUploadFolderError(code);
            }
        }
    }
}
