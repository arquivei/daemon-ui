import '../../components'
import '../../constants/colors.js' as Colors

Card {
    id: root

    property bool isBlocked: false
    property bool isVerifying: false
    property string title
    property string description

    signal purchase()
    signal verify()

    type: Card.Types.Bordered

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

    DsButton {
        id: btnPurchase
        text: 'Contratar download'
        size: DsButton.Sizes.Small
        isBlocked: root.isBlocked
        anchors {
            left: parent.left
            leftMargin: 16
            bottom: parent.bottom
            bottomMargin: 24
        }
        onClicked: purchase()
    }

    DsButton {
        id: btnVerify
        text: 'Já contratei'
        size: DsButton.Sizes.Small
        isLoading: isVerifying
        isBlocked: root.isBlocked
        loadingText: 'Verificando...'
        type: DsButton.Types.Inline
        anchors {
            left: btnPurchase.right
            leftMargin: 16
            verticalCenter: btnPurchase.verticalCenter
        }
        onClicked: verify()
    }
}
