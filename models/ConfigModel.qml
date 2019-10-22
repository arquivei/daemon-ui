import QtQuick 2.0
import QtQml.Models 2.12

ObjectModel {
    id: root

    property string uploadFolder;

    Component.onCompleted: {
        uploadFolder = app.uploadFolder
    }

    function syncUploadFolder() {
        app.uploadFolder = uploadFolder;
    }

    function logout() {
        console.log('Logout user');
    }
}
