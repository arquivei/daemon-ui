import '../..'
import '../../services'
import '../../constants/error-messages.js' as Errors

Model {
    id: root

    property bool hasUploadFolderChanged: false;

    signal validateFolderSuccess(string folder);
    signal validateFolderError(string folder, string errorTitle, string errorMessage);
    signal saveConfigsSuccess();
    signal saveConfigsError(string errorTitle, string errorMessage);
    signal logoutSuccess();

    function logout() {
        authService.logout();
    }

    function validateFolder(folder) {
        configService.validateFolder(folder);
    }

    function saveConfigs(uploadFolder) {
        configService.saveConfigs(uploadFolder);
    }

    function getUploadFolder() {
        return configService.getUploadFolder();
    }

    function getDownloadFolder() {
        return configService.getDownloadFolder();
    }

    function isConfigured() {
        return configService.isConfigured();
    }

    function hasDownload() {
        return configService.hasDownload();
    }

    function getUserEmail() {
        return clientService.getUserEmail();
    }

    function getLogsPath() {
        return clientService.getLogsPath();
    }

    function getWebDetailLink() {
        return clientService.getWebDetailLink();
    }

    function getMacAddress() {
        return clientService.getMacAddress();
    }

    AuthService {
        id: authService
        onLogoutSuccess: {
            root.logoutSuccess();
        }
    }

    ConfigService {
        id: configService
        onValidateFolderSuccess: {
            root.hasUploadFolderChanged = true;
            root.validateFolderSuccess(folder);
        }

        onValidateFolderError: {
            root.validateFolderError(folder, Errors.Config.ValidateFolder[code].title, Errors.Config.ValidateFolder[code].description);
        }

        onSaveConfigsSuccess: {
            root.saveConfigsSuccess();
        }

        onSaveConfigsError: {
            root.saveConfigsError(Errors.Config.SaveConfigs[code].title, Errors.Config.SaveConfigs[code].description);
        }
    }

    ClientService {
        id: clientService
    }
}
