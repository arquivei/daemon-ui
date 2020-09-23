import QtQuick 2.12
import '../../../constants/colors.js' as Colors
import '../../../constants/texts.js' as Texts
import '../../../components'

Card {
    id: root

    property string description
    property string folder
    property string title
    property bool isBlocked: false

    QtObject {
        id: priv

        function displayFolderSelection() {
            if (folder) {
                selectFolderLoader.setSource('./UpdateDownloadFolder.qml', {
                    isBlocked: root.isBlocked,
                    folderPath: root.folder
                })
            } else {
                selectFolderLoader.setSource('../../../components/DsButton.qml', {
                    isBlocked: root.isBlocked,
                    text: Texts.Config.SELECT_FOLDER_BUTTON_LABEL
                })
            }
        }
    }

    signal selectFolderClicked()

    Component.onCompleted: {
        priv.displayFolderSelection();
    }

    onFolderChanged: {
        priv.displayFolderSelection();
    }

    onIsBlockedChanged: {
        priv.displayFolderSelection();
    }

    DsText {
        id: titleText
        text: root.title
        fontSize: 20
        font.weight: 'Bold'
        lineHeight: 24
        color: Colors.BRAND_TERTIARY_DEFAULT

        anchors {
            top: parent.top
            topMargin: 16
            left: parent.left
            leftMargin: 16
        }
    }

    DsText {
        id: descriptionText
        text: root.description
        fontSize: 12
        lineHeight: 18
        color: Colors.GRAYSCALE_500

        anchors {
            top: titleText.bottom
            topMargin: 2
            left: parent.left
            leftMargin: 16
        }
    }

    Loader {
        id: selectFolderLoader

        anchors {
            bottom: parent.bottom
            bottomMargin: 24
            left: parent.left
            leftMargin: 16
        }

        Connections {
            id: selectFolderConnection

            target: folder ? null : selectFolderLoader.item
            onClicked: root.selectFolderClicked()
        }

        Connections {
            id: updateFolderConnection

            target: folder ? selectFolderLoader.item : null
            onUpdateFolderClicked: root.selectFolderClicked()
        }
    }
}
