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
        // Esse método deve retornar uma resposta, porém isso ainda não está implementado
        // const response = QmlBridge.setUploadFolder(folderPath);

        const response = '{ "Success": true, "Message": "Pasta selecionada" }';
        return JSON.parse(response);
    }

    function isAuthenticated() {
        return QmlBridge.isAuthenticated;
    }

    function isConfigured() {
        return QmlBridge.isConfigured;
    }
}

