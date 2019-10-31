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

        if (email.length && password.length) {
            var JsonString = QmlBridge.authenticate(email, password);
            var JsonObject = JSON.parse(JsonString);

            //retrieve values from JSON again
            var success = JsonObject.Success;
            var message = JsonObject.Message;

            if (success == true) {
                app.isAuthenticated = true;
            } else {
                root.errorMsg = message
            }
        }

        const callback = app.isAuthenticated ? successCB : () => errorCB(root.errorMsg);

        const timer = new Timer();
        timer.interval = 1000;
        timer.repeat = false;
        timer.triggered.connect(callback);
        timer.start();
    }
}
