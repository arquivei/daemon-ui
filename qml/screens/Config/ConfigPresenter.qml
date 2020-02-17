import QtQuick 2.12
import '../../helpers/timer.js' as Timer
import '../..'
import '.'

Presenter {
    id: root

    property ConfigModel model: ConfigModel {}

    Component.onCompleted: {
        Timer.setTimeout(() => {
            if(!model.isConfigured()) {
                view.showTourNotification();
            }
        }, 500);
    }

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
