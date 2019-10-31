import QtQuick 2.0
import QtQml.Models 2.12

ObjectModel {
    id: root

    property string uploadFolder;

    Component.onCompleted: {
        uploadFolder = app.uploadFolder
    }

    function syncUploadFolder() {
        QmlBridge.setUploadFolder(uploadFolder)
        app.uploadFolder = uploadFolder;
    }

    function logout() {
        app.isAuthenticated = false;
    }
}
