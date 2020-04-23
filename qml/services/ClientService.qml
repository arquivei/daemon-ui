import QtQuick 2.12
import '../constants/server-codes.js' as Codes

Item {
    id: root

    signal updateUploadProcessingStatus(string processingStatus, int totalSent, int total, bool hasDocumentError);
    signal updateDownloadProcessingStatus(string processingStatus, int totalDownloaded);
    signal updateConnectionStatus(bool isOnline);

    function getUserEmail() {
        return QmlBridge.userEmail;
    }

    function getMacAddress() {
        return QmlBridge.macAddress;
    }

    function getHostName() {
        return QmlBridge.hostName;
    }

    function getLogsPath() {
        return QmlBridge.logsPath;
    }

    function getWebDetailLink() {
        return QmlBridge.webDetailLink;
    }

    Connections {
        target: QmlBridge
        onUploadStatusSignal: {
            if (processingStatus === Codes.DocumentProcessingStatus.STATUS_DEFAULT) {
                updateConnectionStatus(true);
                updateUploadProcessingStatus(Codes.DocumentProcessingStatus[processingStatus], totalSent, total, hasDocumentError);
                return;
            }

            if (processingStatus === Codes.DocumentProcessingStatus.STATUS_ERROR_CONNECTION) {
                updateConnectionStatus(false);
            } else {
                updateConnectionStatus(true);
            }

            updateUploadProcessingStatus(Codes.DocumentProcessingStatus[processingStatus], totalSent, total, hasDocumentError);
        }
        onDownloadStatusSignal: {
            if (processingStatus === Codes.DocumentProcessingStatus.STATUS_DEFAULT) {
                updateConnectionStatus(true);
                updateDownloadProcessingStatus(Codes.DocumentProcessingStatus[processingStatus], totalDownloaded);
                return;
            }

            if (processingStatus === Codes.DocumentProcessingStatus.STATUS_ERROR_CONNECTION) {
                updateConnectionStatus(false);
            } else {
                updateConnectionStatus(true);
            }

            updateDownloadProcessingStatus(Codes.DocumentProcessingStatus[processingStatus], totalDownloaded);
        }
    }
}
