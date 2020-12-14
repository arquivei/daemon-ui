import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../../constants/colors.js' as Colors
import '../../../components'

Item {
    id: root

    property int selectedFoldersLength
    property int numOfFolderErrors

    QtObject {
        id: priv

        property int maxLength: 12

        function getDetails() {
            const pluralSuffix = selectedFoldersLength > 1 ? 's' : '';

            if (numOfFolderErrors === 1) {
                return `<strong>Atenção</strong>: verifique o erro da pasta abaixo. Se necessário, selecione uma nova pasta.`;
            }

            if (numOfFolderErrors) {
                return `<strong>Atenção:</strong> verifique o erro das ${numOfFolderErrors} pastas destacadas. Se necessário, selecione novas pastas.`;
            }

            return selectedFoldersLength ?
                `${selectedFoldersLength} pasta${pluralSuffix} raiz configurada${pluralSuffix} para o Upload de Arquivos` :
                'Nenhuma pasta configurada para o Upload de Arquivos'
        }
    }

    signal addFolder()

    width: parent.width
    height: childrenRect.height

    DsText {
        id: context

        text: 'Configurar integração'
        font.weight: 'Bold'
        fontSize: 14
        lineHeight: 21

        anchors {
            top: parent.top
            left: parent.left
        }
    }

    DsText {
        id: title

        text: 'Gerenciar pastas Upload'
        font.weight: 'Bold'
        color: Colors.BRAND_PRIMARY_DARK
        fontSize: 16
        lineHeight: 19

        anchors {
            top: context.bottom
            topMargin: 8
            left: parent.left
        }
    }

    DsLink {
        id: addFolder

        label: 'Adicionar pasta'
        isDisabled: selectedFoldersLength >= priv.maxLength

        anchors {
            verticalCenter: title.verticalCenter
            right: parent.right
            rightMargin: 8
        }

        onClick: root.addFolder()

        CustomToolTip {
            visible: addFolder.isHovered && addFolder.isDisabled
            text: `Limite máximo de ${priv.maxLength} pastas atingido`
            contentWidth: 100
            y: parent.y
        }
    }

    DsText {
        id: details

        text: priv.getDetails()

        anchors {
            top: title.bottom
            left: parent.left
        }
    }
}
