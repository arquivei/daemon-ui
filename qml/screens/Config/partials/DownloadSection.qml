import QtQuick 2.12
import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../helpers/factory.js' as Factory
import '../../../constants/texts.js' as Texts

DsCard {
    property string title: Texts.Config.DOWNLOAD_SECTION_TITLE
    property string description: Texts.Config.DOWNLOAD_SECTION_DESCRIPTION
    property string folderPath: downloadFolderPath
    property bool isBlocked: false

    function openDialog() {
        downloadFolderDialog.open();
    }

    id: root
    width: parent.width
    height: 142

    DsText {
        id: titleText
        text: root.title
        fontSize: 18
        font.weight: 'Bold'
        lineHeight: 26
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
        lineHeight: 16
        color: Colors.GRAYSCALE_500

        anchors {
            top: titleText.bottom
            left: parent.left
            leftMargin: 16
        }
    }

    Loader {
        id: selectFolderLoader
        sourceComponent: folderPath ? Factory.createPartialFragment('Config', 'UpdateFolder') : Factory.createPartialFragment('Config', 'SelectFolder')

        anchors {
            top: descriptionText.bottom
            topMargin: 24
            left: parent.left
            leftMargin: 16
        }
    }
}
