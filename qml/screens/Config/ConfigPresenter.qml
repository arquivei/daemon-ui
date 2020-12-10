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
            if(!model.isConfigTourViewed() && !model.isConfigured()) {
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
            model.saveConfigs(uploadFolders, downloadFolder);
        }

        onConfigTourViewed: {
            model.setConfigTourIsViewed();
        }

        onGoToManageUpload: {
            GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.GO_TO_MANAGE_UPLOAD)
            app.navigateTo('ManageUpload');
        }

        onReturnToMain: {
            GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.BACK_TO_MAIN);
            model.clearTemp();
            app.navigateTo('Main');
        }

        onCheckDownloadPermission: {
            GA.trackEvent(GA.EventCategories.DOWNLOAD, GA.EventActions.CLICKED_ON_DOWNLOAD_ALREADY_PURCHASED);
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
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.SUCCESS_UPLOAD_FOLDER_CHOICE, folder.path);
            view.setUnsavedChanges(model.hasUnsavedChanges());
            view.setUploadFolder(folder);
        }

        onSelectUploadFolderError: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.ERROR_UPLOAD_FOLDER_CHOICE, `${folder} - ${errorMessage}`);
            view.openGenericErrorModal(errorTitle, errorMessage);
        }

        onSelectDownloadFolderSuccess: {
            GA.trackEvent(GA.EventCategories.DOWNLOAD, GA.EventActions.SUCCESS_DOWNLOAD_FOLDER_CHOICE, folder);
            view.setUnsavedChanges(model.hasUnsavedChanges());
            view.setDownloadFolder(folder);
        }

        onSelectDownloadFolderError: {
            GA.trackEvent(GA.EventCategories.DOWNLOAD, GA.EventActions.ERROR_DOWNLOAD_FOLDER_CHOICE, `${folder} - ${errorMessage}`);
            view.openGenericErrorModal(errorTitle, errorMessage);
        }

        onDownloadAllowed: {
            view.toggleIsVerifyingDownload();
        }

        onDownloadNotAllowed: {
            GA.trackEvent(GA.EventCategories.DOWNLOAD, GA.EventActions.DOWNLOAD_NOT_ALLOWED);
            view.toggleIsVerifyingDownload();
            view.openDownloadNotAllowedModal();
        }

        onDownloadCheckError: {
            view.toggleIsVerifyingDownload();
            view.openGenericErrorModal(errorTitle, errorMessage);
        }

        onSaveConfigsSuccess: {
            const uploadFolders = model.getUploadFolders() || [];
            const label = `Upload: ${JSON.stringify(uploadFolders.map(folder => folder.path))} - Download: ${model.getDownloadFolder()}`;
            GA.trackEvent(GA.EventCategories.CONFIG, GA.EventActions.SUCCESS_SAVE_CONFIG, label);
            view.toggleIsSavingConfigs();
            app.navigateTo('Main');
        }

        onSaveConfigsError: {
            GA.trackEvent(GA.EventCategories.CONFIG, GA.EventActions.ERROR_SAVE_CONFIG, errorMessage);
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

        canDownload: model.canDownload()
        downloadFolder: model.getSelectedDownloadFolder()
        hasUnsavedChanges: model.hasUnsavedChanges()
        isConfigTourViewed: model.isConfigTourViewed()
        logsPath: model.getLogsPath() || null
        macAddress: model.getMacAddress() || null
        showReturnAction: model.isConfigured()
        uploadFolders: model.getSelectedUploadFolders()
        userEmail: model.getUserEmail() || null
        webDetailLink: model.getWebDetailLink() || null

        anchors.fill: parent;
    }
}
