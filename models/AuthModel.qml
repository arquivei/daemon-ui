import QtQuick 2.0
import QtQml.Models 2.12

ObjectModel {
    id: root

    property string email
    property string password
    property string errorMsg: ''
    property string uploadFolder;

    Component.onCompleted: {
        uploadFolder = app.uploadFolder
    }

    function authenticate(successCB, errorCB) {
        function Timer() {
            return Qt.createQmlObject('import QtQuick 2.0; Timer {}', root);
        }

        const callback = email.length && password.length ? successCB : () => errorCB('FAILED :(');
        const timer = new Timer();

        timer.interval = 1000;
        timer.repeat = false;
        timer.triggered.connect(callback);
        timer.start();
    }
}
