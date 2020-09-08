import QtQuick 2.12
import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../helpers/factory.js' as Factory

Card {
    id: root

    property string title
    property string description
    property string folderPath
    property bool isBlocked: false

    signal openDialog

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
        sourceComponent: folderPath ? Factory.createPartialFragment('Config', 'UpdateFolder') : Factory.createPartialFragment('Config', 'SelectFolder')

        anchors {
            bottom: parent.bottom
            bottomMargin: 24
            left: parent.left
            leftMargin: 16
        }
    }
}
