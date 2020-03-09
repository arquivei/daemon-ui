import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/addresses.js' as Address

DsCard {
    property bool isBlocked: false
    property string title
    property string description

    id: root
    width: parent.width
    type: DsCard.Types.Bordered

    height: 132

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

    DsText {
        id: contactText
        text: 'Fale com a gente em '
        fontSize: 12
        lineHeight: 16
        color: Colors.GRAYSCALE_500

        anchors {
            top: descriptionText.bottom
            topMargin: 6
            left: parent.left
            leftMargin: 16
        }
    }

    DsLink {
        id: emailLink
        label: Address.SUPPORT_EMAIL
        href: `mailto:?to=${Address.SUPPORT_EMAIL}`
        isBlocked: root.isBlocked
        fontSize: 12
        lineHeight: 16

        anchors {
            left: contactText.right
            verticalCenter: contactText.verticalCenter
            verticalCenterOffset: -0.5
        }
    }
}
