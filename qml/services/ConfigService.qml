import QtQuick 2.12
import '../constants/error-messages.js' as ErrorMessages

Item {
    id: root

    signal validateDownloadFolderSuccess(string folder);
    signal validateDownloadFolderError(string folder, string code);
    signal validateUploadFolderSuccess(string folder);
    signal validateUploadFolderError(string folder, string code);
    signal saveConfigsSuccess();
    signal saveConfigsError(string code);

    function isMainTourViewed() {
        return QmlBridge.isMainTourViewed;
    }

    function isConfigured() {
        if (QmlBridge.canDownload) {
            return QmlBridge.uploadFolderPath || QmlBridge.downloadFolderPath;
        }

        return QmlBridge.uploadFolderPath;
    }

    function getDownloadFolder() {
        return QmlBridge.downloadFolderPath;
    }

    function getUploadFolder() {
        return QmlBridge.uploadFolderPath;
    }

    function setMainTourIsViewed() {
        QmlBridge.setMainTourIsViewed();
    }

    function canDownload() {
        return QmlBridge.canDownload;
    }

    function validateDownloadFolder(folder) {
        QmlBridge.validateDownloadFolder(folder);
    }

    function validateUploadFolder(folder) {
        QmlBridge.validateUploadFolder(folder);
    }

    function saveConfigs(uploadFolder, downloadFolder) {
        const _uploadFolder = uploadFolder || null;
        const _downloadFolder = downloadFolder || null;
        QmlBridge.saveConfigs(_uploadFolder, _downloadFolder);
    }

    Connections {
        target: QmlBridge
        onValidateDownloadFolderSignal: {
            if (success) {
                root.validateDownloadFolderSuccess(folder);
            } else {
                root.validateDownloadFolderError(folder, code);
            }
        }
        onValidateUploadFolderSignal: {
            if (success) {
                root.validateUploadFolderSuccess(folder);
            } else {
                root.validateUploadFolderError(folder, code);
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
