import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12
import '..'

Item {
    id: root

    signal setUploadFolderSuccess(string folderPath);
    signal setUploadFolderError(string code);

    function isConfigured() {
        return QmlBridge.getUploadFolder() ? true : false;
    }

    function setUploadFolder(folderPath) {
        QmlBridge.setUploadFolder(folderPath);
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
