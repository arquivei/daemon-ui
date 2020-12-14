import QtQuick 2.12
import '../../helpers/timer.js' as Timer
import '../../constants/times.js' as Times
import '../../lib/google-analytics.js' as GA
import '../..'
import '.'

Presenter {
    id: root

    property MainModel model: MainModel {}

    function setValidateFolderTimers() {
        const uploadFolders = model.getUploadFolders();
        const downloadFolder = model.getDownloadFolder();

        if (uploadFolders) {
            Timer.setInterval(() => model.checkUploadFolders(), Times.CHECK_FOLDER_PERMISSION_INTERVAL);
        }

        if (downloadFolder) {
            Timer.setInterval(() => model.validateDownloadFolder(downloadFolder), Times.CHECK_FOLDER_PERMISSION_INTERVAL);
        }
    }

    Component.onCompleted: {
        GA.setClientId(model.getMacAddress());
        GA.trackScreen(GA.ScreenNames.MAIN);
        Timer.setTimeout(() => {
            if(!model.isMainTourViewed()) {
                view.showTourNotification();
            }
        }, Times.TOUR_DELAY);

        setValidateFolderTimers();
    }

    Connections {
        target: view

        onGoToConfig: {
            app.navigateTo('Config');
        }

        onGoToManageUpload: {
            app.navigateTo('ManageUpload');
        }

        onMainTourViewed: {
            model.setMainTourIsViewed();
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

        onUpdateDownloadProcessingStatus: {
            view.setDownloadProcessingStatus(processingStatus, totalDownloaded);
        }

        onUpdateUploadProcessingStatus: {
            view.setUploadProcessingStatus(processingStatus, total, totalSent, hasDocumentError);
        }

        onUpdateConnectionStatus: {
            view.setConnectionStatus(isOnline);
        }

        onCheckAuth: {
            if (!isAuthenticated) {
                GA.trackEvent(GA.EventCategories.AUTHENTICATION, GA.EventActions.ERROR_AUTHENTICATION_SYNC);
                view.showNotAuthenticatedModal();
            }
        }

        onValidateDownloadFolderError: {
            GA.trackEvent(GA.EventCategories.DOWNLOAD, GA.EventActions.ERROR_DOWNLOAD_FOLDER_SYNC, errorMessage);
            view.showFolderValidationErrorModal(errorTitle, errorMessage);
        }

        onDownloadAllowed: {
            view.toggleIsVerifyingDownload();
            app.navigateTo('Config');
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

        onLogoutSuccess: {
            GA.trackEvent(GA.EventCategories.AUTHENTICATION, GA.EventActions.SUCCESS_LOGOUT);
            app.navigateTo('Auth');
        }
    }

    MainView {
        id: view;

        userEmail: model.getUserEmail() || null
        macAddress: model.getMacAddress() || null
        computerName: model.getHostName() || null
        webDetailLink: model.getWebDetailLink() || null
        logsPath: model.getLogsPath() || null
        canDownload: model.canDownload()
        downloadFolder: model.getDownloadFolder() || null
        uploadFolders: model.getUploadFolders() || null
        isMainTourViewed: model.isMainTourViewed()
        anchors.fill: parent;
    }
}
