import QtQuick 2.12
import '../../../components'

DsCard {
    property string folderPath

    property Component selectFolderComponent: Component {
        DsButton {
            id: selectFolderBtn
            text: 'Selecionar pasta'

            onClicked: openDialog()
        }
    }

    property Component updateFolderComponent: Component {
        Item {
            width: root.width

            DsIconText {
                id: iconTextFolder
                icon: "qrc:/images/material-folder.svg"
                text: folderPath
                textMaxLength: 60
            }

            DsLink {
                label: 'Alterar Pasta'

                anchors {
                    left: iconTextFolder.right
                    leftMargin: 16
                    verticalCenter: iconTextFolder.verticalCenter
                }

                onClick: openDialog()
            }
        }
    }

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
        color: '#1D416E'

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
        color: '#737373'

        anchors {
            top: title.bottom
            left: parent.left
            leftMargin: 16
        }
    }

    Loader {
        id: selectFolderLoader
        sourceComponent: folderPath ? updateFolderComponent : selectFolderComponent

        anchors {
            top: description.bottom
            topMargin: 28
            left: parent.left
            leftMargin: 16
        }
    }
}
