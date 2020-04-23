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
        const uploadFolder = model.getUploadFolder();
        const downloadFolder = model.getDownloadFolder();

        if (uploadFolder) {
            Timer.setInterval(() => model.validateUploadFolder(uploadFolder), Times.CHECK_FOLDER_PERMISSION_INTERVAL);
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

        onMainTourViewed: {
            model.setMainTourIsViewed();
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

        onValidateUploadFolderError: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.ERROR_FOLDER_SYNC, errorMessage);
            view.showFolderValidationErrorModal(errorTitle, errorMessage);
        }

        onValidateDownloadFolderError: {
            // track GA Event
            view.showFolderValidationErrorModal(errorTitle, errorMessage);
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
        downloadFolderPath: model.getDownloadFolder() || null
        uploadFolderPath: model.getUploadFolder() || null
        isMainTourViewed: model.isMainTourViewed()
        anchors.fill: parent;
    }
}
