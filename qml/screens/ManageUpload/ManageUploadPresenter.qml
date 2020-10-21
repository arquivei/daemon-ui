import QtQuick 2.12
import '../../lib/google-analytics.js' as GA
import '../..'
import '.'

Presenter {
    id: root

    property ManageUploadModel model: ManageUploadModel {}

    Component.onCompleted: {
        GA.setClientId(model.getMacAddress());
        GA.trackScreen(GA.ScreenNames.MANAGE_UPLOAD);
    }

    Connections {
        target: view

        onAddUploadFolder: {
            model.addUploadFolder(folder);
        }

        onConfirmSelection: {
            model.selectUploadFolders(folders);
        }

        onReturnToConfig: {
            GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.CLOSED_UPLOAD_CONFIG);
            app.navigateTo('Config')
        }
    }

    Connections {
        target: model

        onAddUploadFolderError: {
            view.openErrorModal(title, message);
        }

        onAddUploadFolderSuccess: {
            view.appendToUploadFolderList(folder);
        }

        onSelectUploadFoldersSuccess: {
            GA.trackEvent(GA.EventCategories.UPLOAD, GA.EventActions.UPLOAD_FOLDERS_SELECTION_CONFIRM, `${uploadFolders.length} pasta(s) de upload selecionada(s)`);
            app.navigateTo('Config');
        }
    }

    ManageUploadView {
        id: view;
        downloadFolder: model.getSelectedDownloadFolder()
        uploadFolders: model.getSelectedUploadFolders()
        anchors.fill: parent;
    }
}
