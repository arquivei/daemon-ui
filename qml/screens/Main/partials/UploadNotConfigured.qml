import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/texts.js' as Texts

Card {
    id: root

    property string title: Texts.General.UPLOAD_SECTION_TITLE
    property string description: Texts.Main.UPLOAD_SECTION_NOT_CONFIGURED_DESCRIPTION
    property bool isBlocked: false

    type: Card.Types.Bordered

    DsText {
        id: title
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
            top: title.bottom
            topMargin: 2
            left: parent.left
            leftMargin: 16
        }
    }

    DsLink {
        label: Texts.General.CONFIG_LABEL
        isBlocked: root.isBlocked

        anchors {
            bottom: parent.bottom
            bottomMargin: 24
            left: parent.left
            leftMargin: 16
        }

        onClick: goToConfig()
    }
}
