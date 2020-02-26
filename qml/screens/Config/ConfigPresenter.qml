import QtQuick 2.12
import '../../helpers/timer.js' as Timer
import '../../constants/times.js' as Times
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
        }, Times.TOUR_DELAY);
    }

    Connections {
        target: view

        onValidateFolder: {
            model.validateFolder(folder);
        }

        onSaveConfigs: {
            view.toggleLoading();
            model.saveConfigs(uploadFolder);
        }

        onReturnToMain: {
            app.navigateTo('Main');
        }

        onLogout: {
            model.logout();
        }
    }

    Connections {
        target: model

        onValidateFolderSuccess: {
            view.setUploadFolder(folder);
        }

        onValidateFolderError: {
            view.openErrorDialog(errorTitle, errorMessage);
        }

        onSaveConfigsSuccess: {
            view.toggleLoading();
            app.navigateTo('Main');
        }

        onSaveConfigsError: {
            view.toggleLoading();
            view.openErrorDialog(errorTitle, errorMessage);
        }

        onLogoutSuccess: {
            app.navigateTo('Auth');
        }
    }

    ConfigView {
        id: view;
        uploadFolderPath: model.getUploadFolder() || null
        userEmail: model.getUserEmail() || null
        webDetailLink: model.getWebDetailLink() || null
        showReturnAction: model.getUploadFolder() && true
        hasBeenEdited: model.hasUploadFolderChanged
        anchors.fill: parent;
    }
}
