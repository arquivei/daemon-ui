import QtQuick 2.12
import '../constants/error-messages.js' as ErrorMessages

Item {
    id: root

    signal validateFolderSuccess(string folder);
    signal validateFolderError(string folder, string errorTitle, string errorMessage);
    signal saveConfigsSuccess();
    signal saveConfigsError(string errorTitle, string errorMessage);

    function isConfigured() {
        return QmlBridge.uploadFolderPath ? true : false;
    }

    function getUploadFolder() {
        return QmlBridge.uploadFolderPath;
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
                root.validateFolderError(folder, ErrorMessages.ValidateFolder[code].title, ErrorMessages.ValidateFolder[code].description);
            }
        }
        onSaveConfigsSignal: {
            if (success) {
                root.saveConfigsSuccess();
            } else {
                root.saveConfigsError(ErrorMessages.SaveConfigs[code].title, ErrorMessages.SaveConfigs[code].description);
            }
        }
    }
}
