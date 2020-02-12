import QtQuick 2.12
import '../..'
import '../../services'

Model {
    id: root

    function isConfigured() {
        return configService.isConfigured();
    }

    function isAuthenticated() {
        return authService.isAuthenticated();
    }

    AuthService {
        id: authService
    }

    ConfigService {
        id: configService
    }
}
