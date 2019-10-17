import QtQuick 2.0
import QtQuick.Layouts 1.13

RowLayout {
    spacing: 8
    width: parent.width

    Image {
        id: addFolderIcon
        width: 24
        height: 24
        fillMode: Image.PreserveAspectFit
        source: "images/folder.svg"
    }
    Text {
        id: folderPathText
        Layout.fillWidth: true
        text: window.uploadFolder
        font.family: "Roboto Mono"
        color: "#000"
        elide: Text.ElideLeft
        clip: true
    }
    Component.onCompleted: {
        if (folderPathText.paintedWidth > parent.width) {
            width = parent.width
        } else {
            width = folderPathText.paintedWidth
        }
    }
}
