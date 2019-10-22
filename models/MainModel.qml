import QtQuick 2.0
import QtQml.Models 2.12

ObjectModel {
    id: root

    property string webUrl: 'https://app.arquivei.com.br'
    property string webErrorUrl;
    property string webSuccessUrl;
    property string uploadFolder;

    Component.onCompleted: {
        uploadFolder = app.uploadFolder
    }

    function syncFolder(successCB, errorCB) {
        function Timer() {
            return Qt.createQmlObject('import QtQuick 2.0; Timer {}', root);
        }

        function success() {
            uploadFolder = app.uploadFolder;
            webSuccessUrl = 'https://www.google.com';
            successCB();
        }

        function error() {
            uploadFolder = null;
            webErrorUrl = 'https://br.bing.com';
            errorCB();
        }

        const callback = app.uploadFolder && !app.uploadFolder.includes('Download') ? success : error;
        const timer = new Timer();

        timer.interval = 1000;
        timer.repeat = false;
        timer.triggered.connect(callback);
        timer.start();
    }
}
