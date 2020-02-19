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

        onSaveConfig: {
            console.log('start loading mode');
            console.log('save config logic');
            console.log('navigate to main only when save is successful');

            app.navigateTo('Main');
        }

        onLogout: {
            model.logout();
        }

        onReturnToMain: {
            app.navigateTo('Main');
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
        showReturnAction: model.getUploadFolder() && true
        hasBeenEdited: model.hasUploadFolderChanged
        anchors.fill: parent;
    }
}
