import QtQuick 2.12
import '../../helpers/timer.js' as Timer
import '../../constants/times.js' as Times
import '../../lib/google-analytics.js' as GA
import '../..'
import '.'

Presenter {
    id: root

    property ConfigModel model: ConfigModel {}

    Component.onCompleted: {
        GA.setClientId(model.getMacAddress());
        GA.trackScreen(GA.ScreenNames.CONFIG);
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
            GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.BACK_TO_MAIN);
            app.navigateTo('Main');
        }

        onLogout: {
            model.logout();
        }
    }

    Connections {
        target: model

        onValidateFolderSuccess: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.SUCCESS_FOLDER_CHOICE, folder);
            view.setUploadFolder(folder);
        }

        onValidateFolderError: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.ERROR_FOLDER_CHOICE, `${folder} - ${errorMessage}`);
            view.openErrorDialog(errorTitle, errorMessage);
        }

        onSaveConfigsSuccess: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.SUCCESS_SAVE_CONFIG, model.getUploadFolder());
            view.toggleLoading();
            app.navigateTo('Main');
        }

        onSaveConfigsError: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.ERROR_SAVE_CONFIG, errorMessage);
            view.toggleLoading();
            view.openErrorDialog(errorTitle, errorMessage);
        }

        onLogoutSuccess: {
            GA.trackEvent(GA.EventCategories.AUTHENTICATION, GA.EventActions.SUCCESS_LOGOUT);
            app.navigateTo('Auth');
        }
    }

    ConfigView {
        id: view;
        uploadFolderPath: model.getUploadFolder() || null
        downloadFolderPath: model.getDownloadFolder() || null
        userEmail: model.getUserEmail() || null
        webDetailLink: model.getWebDetailLink() || null
        macAddress: model.getMacAddress() || null
        logsPath: model.getLogsPath() || null
        showReturnAction: model.getUploadFolder() && true
        hasDownload: model.hasDownload()
        hasBeenEdited: model.hasUploadFolderChanged
        anchors.fill: parent;
    }
}
