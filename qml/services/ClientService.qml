import QtQuick 2.12
import '../constants/server-codes.js' as Codes

Item {
    id: root

    signal updateProcessingStatus(string processingStatus, int totalSent, int total, bool hasDocumentError);
    signal updateConnectionStatus(bool isOnline);

    function getUserEmail() {
        return QmlBridge.userEmail;
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
        onClientStatusSignal: {
            if (processingStatus === Codes.DocumentProcessingStatus.STATUS_ERROR_CONNECTION) {
                updateConnectionStatus(false);
            } else {
                updateConnectionStatus(true);
            }

            updateProcessingStatus(Codes.DocumentProcessingStatus[processingStatus], totalSent, total, hasDocumentError);
        }
    }
}
