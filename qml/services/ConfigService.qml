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

    function checkDownloadPermission() {
        QmlBridge.checkDownloadPermission();
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
