import '../..'
import '../../services'

Model {
    id: root

    property bool hasUploadFolderChanged: false;

    signal validateFolderSuccess(string folder);
    signal validateFolderError(string folder, string errorTitle, string errorMessage);
    signal saveConfigsSuccess();
    signal saveConfigsError(string errorTitle, string errorMessage);
    signal logoutSuccess();
    signal logoutError(string msg);

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

    function isConfigured() {
        return configService.isConfigured();
    }

    function getUserEmail() {
        return clientService.getUserEmail();
    }

    function getWebDetailLink() {
        return clientService.getWebDetailLink();
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
        onValidateFolderSuccess: {
            root.hasUploadFolderChanged = true;
            root.validateFolderSuccess(folder);
        }

        onValidateFolderError: {
            root.validateFolderError(folder, errorTitle, errorMessage);
        }

        onSaveConfigsSuccess: {
            root.saveConfigsSuccess();
        }

        onSaveConfigsError: {
            root.saveConfigsError(errorTitle, errorMessage);
        }
    }

    ClientService {
        id: clientService
    }
}
