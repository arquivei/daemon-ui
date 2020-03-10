import QtQuick 2.12
import '../../helpers/timer.js' as Timer
import '../../constants/times.js' as Times
import '../..'
import '.'

Presenter {
    id: root

    property MainModel model: MainModel {}

    Component.onCompleted: {
        Timer.setInterval(() => model.validateFolder(), Times.CHECK_FOLDER_PERMISSION_INTERVAL);
    }

    Connections {
        target: view

        onGoToConfig: {
            app.navigateTo('Config');
        }

        onLogout: {
            model.logout();
        }
    }

    Connections {
        target: model

        onUpdateProcessingStatus: {
            view.setProcessingStatus(processingStatus, total, totalSent, hasDocumentError);
        }

        onUpdateConnectionStatus: {
            view.setConnectionStatus(isOnline);
        }

        onCheckAuth: {
            if (!isAuthenticated) {
                view.showNotAuthenticatedModal();
            }
        }

        onValidateFolderError: {
            view.showFolderValidationErrorModal(errorTitle, errorMessage);
        }

        onLogoutSuccess: {
            app.navigateTo('Auth');
        }
    }

    MainView {
        id: view;
        userEmail: model.getUserEmail() || null
        computerName: model.getHostName() || null
        webDetailLink: model.getWebDetailLink() || null
        logsPath: model.getLogsPath() || null
        hasDownload: model.hasDownload()
        anchors.fill: parent;
    }
}
