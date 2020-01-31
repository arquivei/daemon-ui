import QtQuick 2.12
import '../../../components'

DsCard {
    id: root
    width: parent.width
    type: DsCard.Types.Bordered

    height: 132

    DsText {
        id: title
        text: 'Download de Documentos'
        fontSize: 18
        font.weight: 'Bold'
        lineHeight: 26
        color: '#737373'

        anchors {
            top: parent.top
            topMargin: 16
            left: parent.left
            leftMargin: 16
        }
    }

    DsText {
        id: description
        text: 'Você ainda não possui o módulo de serviço de Download de Documentos.'
        fontSize: 12
        lineHeight: 16
        color: '#737373'

        anchors {
            top: title.bottom
            left: parent.left
            leftMargin: 16
        }
    }

    DsLink {
        id: buyLink
        label: 'Contratar agora'

        anchors {
            top: description.bottom
            topMargin: 28
            left: parent.left
            leftMargin: 16
        }
    }
}
