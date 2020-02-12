import QtQuick 2.12
import '../..'
import '.'

Presenter {
    id: root

    property ConfigModel model: ConfigModel {}

    Connections {
        target: view

        onSelectUploadFolder: {
            model.setUploadFolder(folderPath);
        }

        onLogout: {
            model.logout();
        }
    }

    Connections {
        target: model

        onSetUploadFolderSuccess: {
            view.setFolderPath(folderPath);
        }

        onLogoutSuccess: {
            app.navigateTo('Auth');
        }
    }

    ConfigView {
        id: view;
        uploadFolderPath: model.getUploadFolder() || null
        anchors.fill: parent;
    }
}
