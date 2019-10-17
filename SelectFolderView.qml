import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13
import QtQuick.Dialogs 1.3 as Dialogs

Page {
    id: authView

    Dialogs.FileDialog {
        id: selectFolderDialog
        selectFolder : true
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            window.uploadFolder = selectFolderDialog.fileUrl
            stack.pop()
        }
    }

    Text {
        id: viewTitle
        text: "SELECT FOLDER"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        font.family: "Roboto Mono"
        font.weight: "Bold"
        font.pixelSize: 14
    }

    Item {
        anchors.left: parent.left
        anchors.top: parent.top

        MouseArea {
            id: mouseAreaSettings
            x: 0
            y: 0
            width: backIcon.width
            height: backIcon.height
            hoverEnabled: true
            onClicked: {
                stack.pop()
            }
            cursorShape: Qt.PointingHandCursor
        }

        Image {
            id: backIcon
            width: 24
            height: 24
            fillMode: Image.PreserveAspectFit
            source: "images/back.svg"
        }
    }

    Button {
        id: startButton
        anchors.bottom: parent.bottom
        width: parent.width
        background: Rectangle {
            color: '#000'
            radius: 20
        }
        contentItem: Text {
            color: '#fff'
            text: 'SELECT FOLDER'
            font.family: "Roboto Mono"
            font.weight: "Bold"
            horizontalAlignment: Text.AlignHCenter
        }
        onClicked: {
            selectFolderDialog.open()
        }
    }
}
