import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12
import '..'

Item {
    id: root

    signal authenticateSuccess();
    signal authenticateError(string code);
    signal logoutSuccess();
    signal logoutError(string code);

    function authenticate(email, password) {
        QmlBridge.authenticate(email, password);
    }

    function logout() {
        QmlBridge.logout();
    }

    function isAuthenticated() {
        return QmlBridge.isAuthenticated;
    }

    Connections {
        target: QmlBridge
        onLoginSignal: {
            if (success) {
                root.authenticateSuccess();
            } else {
                root.authenticateError(code);
            }
        }
        onLogoutSignal: {
            if (success) {
                root.logoutSuccess();
            } else {
                root.logoutError(code);
            }
        }
    }
}
