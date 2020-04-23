import '../..'
import '../../services'
import '../../constants/error-messages.js' as Errors

Model {
    id: root

    property bool hasUploadFolderChanged: false;
    property bool hasDownloadFolderChanged: false;

    signal selectUploadFolderSuccess(string folder);
    signal selectUploadFolderError(string folder, string errorTitle, string errorMessage);
    signal selectDownloadFolderSuccess(string folder);
    signal selectDownloadFolderError(string folder, string errorTitle, string errorMessage);
    signal saveConfigsSuccess();
    signal saveConfigsError(string errorTitle, string errorMessage);
    signal logoutSuccess();

    function logout() {
        authService.logout();
    }

    function selectDownloadFolder(folder) {
        configService.validateDownloadFolder(folder);
    }

    function selectUploadFolder(folder) {
        configService.validateUploadFolder(folder);
    }

    function saveConfigs(uploadFolder, downloadFolder) {
        configService.saveConfigs(uploadFolder, downloadFolder);
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

    function canDownload() {
        return configService.canDownload();
    }

    function hasBeenEdited() {
        return hasDownloadFolderChanged || hasUploadFolderChanged;
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

        onValidateDownloadFolderSuccess: {
            root.hasDownloadFolderChanged = true;
            root.selectDownloadFolderSuccess(folder);
        }

        onValidateDownloadFolderError: {
            root.selectDownloadFolderError(folder, Errors.Config.ValidateFolder[code].title, Errors.Config.ValidateFolder[code].description);
        }

        onValidateUploadFolderSuccess: {
            root.hasUploadFolderChanged = true;
            root.selectUploadFolderSuccess(folder);
        }

        onValidateUploadFolderError: {
            root.selectUploadFolderError(folder, Errors.Config.ValidateFolder[code].title, Errors.Config.ValidateFolder[code].description);
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
