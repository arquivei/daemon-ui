import QtQuick 2.12

Item {
    id: root

    signal authenticateSuccess();
    signal authenticateError(string message);
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
        onAuthenticateSignal: {
            if (success) {
                root.authenticateSuccess();
            } else {
                root.authenticateError(message);
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
