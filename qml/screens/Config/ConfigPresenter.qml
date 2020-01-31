import QtQuick 2.12
import '../..'
import '.'

Presenter {
    id: root

    property ConfigModel model: ConfigModel {}

    Connections {
        target: view

        onSelectUploadFolder: {
            model.setUploadFolder(folderPath);
        }
    }

    Connections {
        target: model
        onSetUploadFolderSuccess: {
            view.setFolderPath(folderPath);
        }
    }

    ConfigView {
        id: view;
        anchors.fill: parent;
    }
}
