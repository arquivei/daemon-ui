import QtQuick 2.12
import '../..'
import '.'

Presenter {
    id: root

    property MainModel model: MainModel {}

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

        onFolderErrorValidation: {
            view.showFolderPermissionModal();
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
        anchors.fill: parent;
    }
}
