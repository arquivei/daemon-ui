import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/texts.js' as Texts

DsCard {
    property string title: Texts.Main.UPLOAD_SECTION_TITLE
    property string description: Texts.Main.UPLOAD_SECTION_NOT_CONFIGURED_DESCRIPTION
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
        label: Texts.General.CONFIG_LABEL
        isBlocked: root.isBlocked

        anchors {
            top: descriptionText.bottom
            topMargin: 24
            left: parent.left
            leftMargin: 16
        }

        onClick: goToConfig()
    }
}
