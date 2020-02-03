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
            app.toLogin();
        }
    }

    ConfigView {
        id: view;
        anchors.fill: parent;
    }
}
