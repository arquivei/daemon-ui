import '../..'
import '../../services'

Model {
    id: root

    signal updateProcessingStatus(string processingStatus, int totalSent, int total, bool hasDocumentError);
    signal updateConnectionStatus(bool isOnline);
    signal checkAuth(bool isAuthenticated);
    signal folderErrorValidation();
    signal logoutSuccess();
    signal logoutError(string error);

    function getHostName() {
        return clientService.getHostName();
    }

    function getUserEmail() {
        return clientService.getUserEmail();
    }

    function getWebDetailLink() {
        return clientService.getWebDetailLink();
    }

    function validateFolder() {
        configService.validateFolder(configService.getUploadFolder());
    }

    function logout() {
        authService.logout();
    }

    ClientService {
        id: clientService

        onUpdateProcessingStatus: {
            root.updateProcessingStatus(processingStatus, totalSent, total, hasDocumentError);
            root.checkAuth(authService.isAuthenticated());
        }

        onUpdateConnectionStatus: {
            root.updateConnectionStatus(isOnline);
        }
    }

    AuthService {
        id: authService

        onLogoutSuccess: {
            root.logoutSuccess();
        }
        onLogoutError: {
            root.logoutError('Logout Error')
        }
    }

    ConfigService {
        id: configService

        onValidateFolderError: {
            root.folderErrorValidation();
        }
    }
}
