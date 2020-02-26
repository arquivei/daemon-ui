import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/addresses.js' as Address

DsCard {
    property bool isBlocked: false

    id: root
    width: parent.width
    type: DsCard.Types.Bordered

    height: 132

    DsText {
        id: title
        text: 'Download de Documentos: em breve!'
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
        text: 'Baixe automaticamente seus XMLs direto da Arquivei. Seja um dos primeiros a testar!'
        fontSize: 12
        lineHeight: 16
        color: Colors.GRAYSCALE_500

        anchors {
            top: title.bottom
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
