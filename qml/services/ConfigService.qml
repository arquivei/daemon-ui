import QtQuick 2.12
import '../constants/server-codes.js' as Codes

Item {
    id: root

    signal validateDownloadFolderSuccess(string folder);
    signal validateDownloadFolderError(string folder, string code);
    signal validateUploadFolderSuccess(string folder);
    signal validateUploadFolderError(string folder, string code);
    signal downloadAllowed();
    signal downloadNotAllowed();
    signal downloadCheckError(string code);
    signal saveConfigsSuccess();
    signal saveConfigsError(string code);

    function isConfigTourViewed() {
        return QmlBridge.isConfigTourViewed;
    }

    function isMainTourViewed() {
        return QmlBridge.isMainTourViewed;
    }

    function isConfigured() {
        const isUploadConfigured = !!(QmlBridge.uploadFolderPaths && QmlBridge.uploadFolderPaths.length)
        const isDownloadConfigured = !!QmlBridge.downloadFolderPath

        if (QmlBridge.canDownload) {
            return isUploadConfigured || isDownloadConfigured;
        }

        return isUploadConfigured;
    }

    function getDownloadFolder() {
        return QmlBridge.downloadFolderPath;
    }

    function getUploadFolders() {
        const uploadFolders = QmlBridge.uploadFolderPaths || null;
        return JSON.parse(uploadFolders);
    }

    function setConfigTourIsViewed() {
        QmlBridge.setConfigTourIsViewed();
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

    function checkDownloadPermission() {
        QmlBridge.checkDownloadPermission();
    }

    function checkUploadFolders() {
        QmlBridge.checkUploadFolders();
    }

    function saveConfigs(uploadFolders, downloadFolder) {
        const _uploadFolders = uploadFolders || [];
        const _downloadFolder = downloadFolder || null;
        QmlBridge.saveConfigs(_uploadFolders, _downloadFolder);
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
        onDownloadPermissionSignal: {
            switch (code) {
            case Codes.DownloadPermissionStatus.DOWNLOAD_ALLOWED:
                root.downloadAllowed();
                break;
            case Codes.DownloadPermissionStatus.DOWNLOAD_NOT_ALLOWED:
                root.downloadNotAllowed();
                break;
            default:
                root.downloadCheckError(code);
            }
        }
    }
}
