import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml.Models 2.12

Item {
    id: root

    function authenticate(email, password) {
        const response = QmlBridge.authenticate(email, password);
        return JSON.parse(response);
    }

    function setUploadFolder(folderPath) {
        const response = QmlBridge.setUploadFolder(folderPath);
        return JSON.parse(response);
    }

    function isAuthenticated() {
        return QmlBridge.isAuthenticated;
    }

    function isConfigured() {
        return QmlBridge.isConfigured;
    }
}

