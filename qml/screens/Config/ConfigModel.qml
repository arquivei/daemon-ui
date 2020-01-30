import QtQuick 2.12
import '../..'
import '../../services'

Model {
    id: root

    signal setUploadFolderSuccess(string folderPath);
    signal setUploadFolderError(string msg);

    property Server server: Server {}

    function setUploadFolder(folderPath) {
        const response = server.setUploadFolder(folderPath);
        const success = response.Success;
        const message = response.Message;

        if (success) {
            setUploadFolderSuccess(folderPath);
        } else {
            setUploadFolderError(message);
        }
    }

    function isConfigured() {
        return server.isConfigured();
    }
}
