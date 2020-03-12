import QtQuick 2.12
import '../constants/error-messages.js' as ErrorMessages

Item {
    id: root

    signal validateFolderSuccess(string folder);
    signal validateFolderError(string folder, string code);
    signal saveConfigsSuccess();
    signal saveConfigsError(string code);

    function isMainTourViewed() {
        return QmlBridge.isMainTourViewed;
    }

    function isConfigured() {
        return QmlBridge.uploadFolderPath ? true : false;
    }

    function getUploadFolder() {
        return QmlBridge.uploadFolderPath;
    }

    function setMainTourIsViewed() {
        QmlBridge.setMainTourIsViewed();
    }

    function getDownloadFolder() {
        return null;
    }

    function hasDownload() {
        return false;
    }

    function validateFolder(folder) {
        QmlBridge.validateFolder(folder);
    }

    function saveConfigs(uploadFolder) {
        QmlBridge.saveConfigs(uploadFolder);
    }

    Connections {
        target: QmlBridge
        onValidateFolderSignal: {
            if (success) {
                root.validateFolderSuccess(folder);
            } else {
                root.validateFolderError(folder, code);
            }
        }
        onSaveConfigsSignal: {
            if (success) {
                root.saveConfigsSuccess();
            } else {
                root.saveConfigsError(code);
            }
        }
    }
}
