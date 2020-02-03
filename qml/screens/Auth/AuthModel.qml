import QtQuick 2.12
import '../..'
import '../../services'

Model {
    id: root

    signal loginSuccess;
    signal loginError(string msg);

    function login(email, password) {
        if (email.length && password.length) {
            authService.authenticate(email, password);
        } else {
            loginError('Insira um email e um password válido');
        }
    }

    function isConfigured() {
        return configService.isConfigured();
    }

    AuthService {
        id: authService
        onAuthenticateSuccess: {
            root.loginSuccess()
        }
        onAuthenticateError: {
            root.loginError('Login Error')
        }
    }

    ConfigService {
        id: configService
    }
}
