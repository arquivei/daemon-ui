import QtQuick 2.12
import '../..'
import '../../services'

Model {
    id: root

    property bool hasUploadFolderChanged: false;

    signal setUploadFolderSuccess(string folderPath);
    signal setUploadFolderError(string msg);
    signal logoutSuccess();
    signal logoutError(string msg);

    function logout() {
        authService.logout();
    }

    function setUploadFolder(folderPath) {
        configService.setUploadFolder(folderPath);
    }

    function getUploadFolder() {
        return configService.getUploadFolder();
    }

    function isConfigured() {
        return configService.isConfigured();
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
        onSetUploadFolderSuccess: {
            root.hasUploadFolderChanged = true;
            root.setUploadFolderSuccess(folderPath);
        }
        onSetUploadFolderError: {
            root.setUploadFolderError('Set Upload Folder Error')
        }
    }
}
