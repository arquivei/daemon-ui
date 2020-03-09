import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/texts.js' as Texts

DsCard {
    property string title
    property string description
    property string hireDownloadUrl
    property bool isBlocked: false

    id: root
    width: parent.width
    type: DsCard.Types.Bordered

    height: 132

    DsText {
        id: title
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
            top: title.bottom
            left: parent.left
            leftMargin: 16
        }
    }

    DsLink {
        label: Texts.General.HIRE_DOWNLOAD_LABEL
        isBlocked: root.isBlocked
        href: root.hireDownloadUrl

        anchors {
            top: descriptionText.bottom
            topMargin: 24
            left: parent.left
            leftMargin: 16
        }
    }
}
