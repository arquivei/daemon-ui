import '../..'
import '../../services'
import '../../constants/error-messages.js' as Errors

Model {
    id: root

    signal updateProcessingStatus(string processingStatus, int totalSent, int total, bool hasDocumentError);
    signal updateConnectionStatus(bool isOnline);
    signal checkAuth(bool isAuthenticated);
    signal validateFolderError(string errorTitle, string errorMessage);
    signal logoutSuccess();

    function getHostName() {
        return clientService.getHostName();
    }

    function getUserEmail() {
        return clientService.getUserEmail();
    }

    function getWebDetailLink() {
        return clientService.getWebDetailLink();
    }

    function getMacAddress() {
        return clientService.getMacAddress();
    }

    function getLogsPath() {
        return clientService.getLogsPath();
    }

    function setMainTourIsViewed() {
        configService.setMainTourIsViewed();
    }

    function hasDownload() {
        return configService.hasDownload();
    }

    function isMainTourViewed() {
        return configService.isMainTourViewed();
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
    }

    ConfigService {
        id: configService

        onValidateFolderError: {
            root.validateFolderError(Errors.Main.ValidateFolder[code].title, Errors.Main.ValidateFolder[code].description);
        }
    }
}
