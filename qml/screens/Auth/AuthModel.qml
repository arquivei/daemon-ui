import QtQuick 2.0
import '../..'
import '../../services'

Model {
    id: root

    signal loginSuccess;
    signal loginError(string msg);

    property Server server: Server {}

    function login(email, password) {
        if (email.length && password.length) {
            const response = server.authenticate(email, password);
            const success = response.Success;
            const message = response.Message;

            if (success) {
                app.isAuthenticated = true;
                loginSuccess();
            } else {
                loginError(message);
            }
        } else {
            loginError('Insira um email e um password válido');
        }
    }

    function isConfigured() {
        return server.isConfigured();
    }
}
