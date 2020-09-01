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

        onSelectDownloadFolder: {
            model.selectDownloadFolder(folder);
        }

        onSelectUploadFolder: {
            model.selectUploadFolder(folder);
        }

        onSaveConfigs: {
            view.toggleIsSavingConfigs();
            model.saveConfigs(uploadFolder, downloadFolder);
        }

        onReturnToMain: {
            GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.BACK_TO_MAIN);
            app.navigateTo('Main');
        }

        onCheckDownloadPermission: {
            view.toggleIsVerifyingDownload();
            model.checkDownloadPermission();
        }

        onLogout: {
            model.logout();
        }
    }

    Connections {
        target: model

        onSelectUploadFolderSuccess: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.SUCCESS_FOLDER_CHOICE, folder);
            view.setUploadFolder(folder);
        }

        onSelectUploadFolderError: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.ERROR_FOLDER_CHOICE, `${folder} - ${errorMessage}`);
            view.openGenericErrorModal(errorTitle, errorMessage);
        }

        onSelectDownloadFolderSuccess: {
            // Trackear evento GA
            view.setDownloadFolder(folder);
        }

        onSelectDownloadFolderError: {
            // Trackear evento GA
            view.openGenericErrorModal(errorTitle, errorMessage);
        }

        onDownloadAllowed: {
            view.toggleIsVerifyingDownload();
        }

        onDownloadNotAllowed: {
            view.toggleIsVerifyingDownload();
            view.openDownloadNotAllowedModal();
        }

        onDownloadCheckError: {
            view.toggleIsVerifyingDownload();
            view.openGenericErrorModal(errorTitle, errorMessage);
        }

        onSaveConfigsSuccess: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.SUCCESS_SAVE_CONFIG, model.getUploadFolder());
            view.toggleIsSavingConfigs();
            app.navigateTo('Main');
        }

        onSaveConfigsError: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.ERROR_SAVE_CONFIG, errorMessage);
            view.toggleIsSavingConfigs();
            view.openGenericErrorModal(errorTitle, errorMessage);
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
        showReturnAction: model.getUploadFolder() || model.getDownloadFolder()
        canDownload: model.canDownload()
        hasBeenEdited: model.hasBeenEdited()
        anchors.fill: parent;
    }
}
