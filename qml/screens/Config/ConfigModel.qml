import '../..'
import '../../services'
import '../../constants/error-messages.js' as Errors
import '../../constants/temp.js' as Temp

Model {
    id: root

    signal selectUploadFolderSuccess(string folder);
    signal selectUploadFolderError(string folder, string errorTitle, string errorMessage);
    signal selectDownloadFolderSuccess(string folder);
    signal selectDownloadFolderError(string folder, string errorTitle, string errorMessage);
    signal downloadAllowed();
    signal downloadNotAllowed();
    signal downloadCheckError(string errorTitle, string errorMessage);
    signal saveConfigsSuccess();
    signal saveConfigsError(string errorTitle, string errorMessage);
    signal logoutSuccess();

    function getDownloadFolder() {
        return configService.getDownloadFolder();
    }

    function getLogsPath() {
        return clientService.getLogsPath();
    }

    function getMacAddress() {
        return clientService.getMacAddress();
    }

    function getSelectedDownloadFolder() {
        return app.temp[Temp.DOWNLOAD_FOLDER] || getDownloadFolder() || null
    }

    function getSelectedUploadFolders() {
        const selectedUploadFolders = app.temp[Temp.UPLOAD_FOLDERS] || getUploadFolders();
        return selectedUploadFolders && selectedUploadFolders.length ? selectedUploadFolders : null;
    }

    function getUploadFolders() {
        return configService.getUploadFolders();
    }

    function getUserEmail() {
        return clientService.getUserEmail();
    }

    function getWebDetailLink() {
        return clientService.getWebDetailLink();
    }

    function isConfigTourViewed() {
        return configService.isConfigTourViewed();
    }

    function isConfigured() {
        return configService.isConfigured();
    }

    function canDownload() {
        return configService.canDownload();
    }

    function hasUnsavedChanges() {
        return !!app.temp[Temp.UNSAVED_CHANGES];
    }

    function setConfigTourIsViewed() {
        return configService.setConfigTourIsViewed();
    }

    function checkDownloadPermission() {
        configService.checkDownloadPermission();
    }

    function clearTemp() {
        app.temp = {};
    }

    function logout() {
        authService.logout();
    }

    function saveConfigs(uploadFolders, downloadFolder) {
        configService.saveConfigs(uploadFolders, downloadFolder);
    }

    function selectDownloadFolder(folder) {
        configService.validateDownloadFolder(folder);
    }

    function selectUploadFolder(folder) {
        configService.validateUploadFolder(folder);
    }

    AuthService {
        id: authService

        onLogoutSuccess: {
            clearTemp();
            root.logoutSuccess();
        }
    }

    ConfigService {
        id: configService

        onValidateDownloadFolderSuccess: {
            app.temp[Temp.DOWNLOAD_FOLDER] = folder;
            app.temp[Temp.UNSAVED_CHANGES] = true;
            root.selectDownloadFolderSuccess(folder);
        }

        onValidateDownloadFolderError: {
            root.selectDownloadFolderError(folder, Errors.General.ValidateFolder[code].title, Errors.General.ValidateFolder[code].description);
        }

        onValidateUploadFolderSuccess: {
            app.temp[Temp.UPLOAD_FOLDERS] = [folder];
            app.temp[Temp.UNSAVED_CHANGES] = true;
            root.selectUploadFolderSuccess(folder);
        }

        onValidateUploadFolderError: {
            root.selectUploadFolderError(folder, Errors.General.ValidateFolder[code].title, Errors.General.ValidateFolder[code].description);
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

        onSaveConfigsSuccess: {
            clearTemp();
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
