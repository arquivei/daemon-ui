import '../..'
import '../../services'
import '../../constants/error-messages.js' as Errors
import '../../constants/temp.js' as Temp

Model {
    id: root

    signal addUploadFolderError(string folder, string title, string message);
    signal addUploadFolderSuccess(var folder);
    signal selectUploadFoldersSuccess(var uploadFolders);

    function getMacAddress() {
        return clientService.getMacAddress();
    }

    function getSelectedDownloadFolder() {
        return app.temp[Temp.DOWNLOAD_FOLDER] || configService.getDownloadFolder();
    }

    function getSelectedUploadFolders() {
        return app.temp[Temp.UPLOAD_FOLDERS] || configService.getUploadFolders();
    }

    function addUploadFolder(folder) {
        configService.validateUploadFolder(folder);
    }

    function selectUploadFolders(uploadFolders) {
        app.temp[Temp.UPLOAD_FOLDERS] = uploadFolders;
        app.temp[Temp.UNSAVED_CHANGES] = true;
        root.selectUploadFoldersSuccess(uploadFolders);
    }

    ConfigService {
        id: configService

        onValidateUploadFolderSuccess: {
            const addedFolder = { path: folder, code: null };
            root.addUploadFolderSuccess(addedFolder);
        }

        onValidateUploadFolderError: {
            root.addUploadFolderError(folder, Errors.General.ValidateFolder[code].title, Errors.General.ValidateFolder[code].description);
        }
    }

    ClientService {
        id: clientService
    }
}
