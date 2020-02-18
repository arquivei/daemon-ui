import QtQuick 2.12
import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../helpers/factory.js' as Factory

DsCard {
    property string folderPath
    property bool isBlocked: false

    signal openDialog

    id: root
    width: parent.width
    height: 142

    DsText {
        id: title
        text: 'Upload de Documentos'
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
        id: description
        text: 'Selecione a pasta onde estão os arquivos que deseja enviar para a Arquivei'
        fontSize: 12
        lineHeight: 16
        color: Colors.GRAYSCALE_500

        anchors {
            top: title.bottom
            left: parent.left
            leftMargin: 16
        }
    }

    Loader {
        id: selectFolderLoader
        sourceComponent: folderPath ? Factory.createPartialFragment('Config', 'UpdateUploadFolder') : Factory.createPartialFragment('Config', 'SelectUploadFolder')

        anchors {
            top: description.bottom
            topMargin: 28
            left: parent.left
            leftMargin: 16
        }
    }
}
