import '../..'
import '../../services'
import '../../constants/error-messages.js' as Errors

Model {
    id: root

    signal updateUploadProcessingStatus(string processingStatus, int totalSent, int total, bool hasDocumentError);
    signal updateDownloadProcessingStatus(string processingStatus, int totalDownloaded);
    signal updateConnectionStatus(bool isOnline);
    signal checkAuth(bool isAuthenticated);
    signal validateDownloadFolderError(string errorTitle, string errorMessage);
    signal validateUploadFolderError(string errorTitle, string errorMessage);
    signal downloadAllowed();
    signal downloadNotAllowed();
    signal downloadCheckError(string errorTitle, string errorMessage);
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

    function getUploadFolder() {
        return configService.getUploadFolder();
    }

    function getDownloadFolder() {
        return configService.getDownloadFolder();
    }

    function setMainTourIsViewed() {
        configService.setMainTourIsViewed();
    }

    function canDownload() {
        return configService.canDownload();
    }

    function isMainTourViewed() {
        return configService.isMainTourViewed();
    }

    function validateDownloadFolder(folder) {
        configService.validateDownloadFolder(folder);
    }

    function validateUploadFolder(folder) {
        configService.validateUploadFolder(folder);
    }

    function checkDownloadPermission() {
        configService.checkDownloadPermission();
    }

    function logout() {
        authService.logout();
    }

    ClientService {
        id: clientService

        onUpdateUploadProcessingStatus: {
            root.updateUploadProcessingStatus(processingStatus, totalSent, total, hasDocumentError);
            root.checkAuth(authService.isAuthenticated());
        }

        onUpdateDownloadProcessingStatus: {
            root.updateDownloadProcessingStatus(processingStatus, totalDownloaded);
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

        onValidateDownloadFolderError: {
            root.validateDownloadFolderError(Errors.Main.ValidateDownloadFolder[code].title, Errors.Main.ValidateDownloadFolder[code].description);
        }

        onValidateUploadFolderError: {
            root.validateUploadFolderError(Errors.Main.ValidateUploadFolder[code].title, Errors.Main.ValidateUploadFolder[code].description);
        }

        onDownloadAllowed: {
            root.downloadAllowed();
        }

        onDownloadNotAllowed: {
            root.downloadNotAllowed();
        }

        onDownloadCheckError: {
            root.downloadCheckError(Errors.General.CheckDownloadPermission[code].title, Errors.General.CheckDownloadPermission[code].description)
        }
    }
}
