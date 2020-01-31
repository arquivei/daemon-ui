import QtQuick 2.12
import '../..'
import '../../services'

Model {
    id: root

    signal setUploadFolderSuccess(string folderPath);
    signal setUploadFolderError(string code);
    signal logoutSuccess();
    signal logoutError();

    property Server server: Server {}

    function setUploadFolder(folderPath) {
        const response = server.setUploadFolder(folderPath);
        const success = response.Success;
        const code = response.Code;

        if (success) {
            setUploadFolderSuccess(folderPath);
        } else {
            setUploadFolderError(code);
        }
    }

    function logout() {
        const response = server.logout();
        const success = response.Success;

        if (success) {
            logoutSuccess();
        } else {
            logoutError();
        }
    }

    function isConfigured() {
        return server.isConfigured();
    }
}
