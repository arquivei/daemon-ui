import QtQuick 2.12
import '../../../components'
import '../../../constants/colors.js' as Colors

Item {
    property bool show

    id: root
    visible: show
    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height

    DsText {
        id: firstRow
        text: 'Um ou mais arquivos não foram enviados.'
        color: Colors.EXTRA_ORANGE_DEFAULT
        lineHeight: 16
    }

    DsText {
        text: 'Clique em <strong>Ver Detalhes</strong> para visualizar as falhas ocorridas.'
        lineHeight: 16

        anchors {
            left: firstRow.left
            top: firstRow.bottom
        }
    }
}
