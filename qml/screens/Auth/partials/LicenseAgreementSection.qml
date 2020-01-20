import QtQuick 2.0
import '../../../components'

Item {
    property string useTermsUrl
    property string privacyPolicyUrl

    id: root

    height: childrenRect.height

    Item {
        id: itemLicenseTxt1

        width: childrenRect.width
        height: childrenRect.height
        anchors.horizontalCenter: parent.horizontalCenter

        DsText {
            id: textPartial1
            text: 'Ao continuar, você concorda com as '
        }

        DsLink {
            id: linkUseTerms
            href: useTermsUrl
            label: 'Condições de Uso'
            fontSize: 12
            lineHeight: 18

            anchors.left: textPartial1.right
            anchors.verticalCenter: textPartial1.verticalCenter
        }
    }

    Item {
        id: itemLicenseTxt2

        width: childrenRect.width
        height: childrenRect.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: itemLicenseTxt1.bottom

        DsText {
            id: textPartial3
            text: 'e com a '
        }

        DsLink {
            id: linkPrivacyPolicy
            href: privacyPolicyUrl
            label: 'Política de Privacidade'
            fontSize: 12
            lineHeight: 18

            anchors.left: textPartial3.right
            anchors.verticalCenter: textPartial3.verticalCenter
        }

        DsText {
            id: textPartial4
            text: ' da Arquivei'

            anchors.left: linkPrivacyPolicy.right
            anchors.verticalCenter: linkPrivacyPolicy.verticalCenter
        }
    }
}
