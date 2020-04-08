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

    function getMacAddress() {
        return clientService.getMackAddress();
    }

    function getEmail() {
        return clientService.getUserEmail();
    }

    AuthService {
        id: authService
        onAuthenticateSuccess: {
            root.loginSuccess()
        }
        onAuthenticateError: {
            root.loginError(message)
        }
    }

    ConfigService {
        id: configService
    }

    ClientService {
        id: clientService
    }
}
