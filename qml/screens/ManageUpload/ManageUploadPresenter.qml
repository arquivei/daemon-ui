import QtQuick 2.12
import '../..'
import '.'

Presenter {
    id: root

    property ManageUploadModel model: ManageUploadModel {}

    Connections {
        target: view

        onAddUploadFolder: {
            model.addUploadFolder(folder);
        }

        onConfirmSelection: {
            model.selectUploadFolders(folders);
        }

        onReturnToConfig: app.navigateTo('Config')
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
