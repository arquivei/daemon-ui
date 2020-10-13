import QtQuick 2.12
import QtQuick.Controls 2.12

ScrollView {
    id: root

    property var items: []

    signal remove(string path)

    width: parent.width
    height: 313
    clip: true

    onItemsChanged: {
        data.clear();
        data.append(items);
    }

    ListView {
        id: list

        model: ListModel {
            id: data
        }

        delegate: UploadFolderItem {
            folder: path
            hasDivider: index + 1 < list.count
            onRemove: root.remove(path)
        }

        anchors {
            fill: parent;
        }
    }
}
