import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../components'
import './partials'
import '../../constants/colors.js' as Colors
import '../../helpers/factory.js' as Factory

Page {
    property string uploadFolderPath
    property var tourSteps: [
    {
        id: 'step1',
        ref: uploadSection,
        parent: content,
        title: 'Configurar Upload',
        description: 'Clique em selecionar pasta para configurar o envio de documentos para a plataforma Arquivei.',
        chipInfo: '01/04',
        position: {
            top: uploadSection.bottom,
            topMargin: 8,
            left: uploadSection.left
        },
        nextLabel: 'Avançar'
    },
    {
        id: 'step2',
        ref: downloadSection,
        parent: content,
        title: 'Configurar Download',
        description: 'Ainda não possui o módulo de download que baixa os documentos da Arquivei para seu computador? Para contratá-lo basta clicar no link abaixo.',
        chipInfo: '02/04',
        position: {
            bottom: downloadSection.top,
            bottomMargin: 8,
            left: downloadSection.left
        },
        prevLabel: 'Voltar',
        nextLabel: 'Avançar'
    },
    {
        id: 'step3',
        ref: btnSave,
        parent: content,
        title: 'Finalizar Configuração',
        description: 'Ao selecionar a pasta de Upload e/ou contratar Download e configurá-lo, você seguirá em frente e salvará as configurações escolhidas clicando em Prosseguir.',
        chipInfo: '03/04',
        position: {
            bottom: btnSave.top,
            bottomMargin: 8,
            right: btnSave.right
        },
        prevLabel: 'Voltar',
        nextLabel: 'Próximo'
    },
    {
        id: 'step4',
        ref: btnTour,
        parent: content,
        title: 'Ajuda',
        description: 'O tour do app ficará disponível para você, até a finalização da configuração, neste botão.',
        chipInfo: 'FIM',
        showCloseAction: false,
        position: {
            bottom: btnTour.top,
            bottomMargin: 8,
            left: btnTour.left
        },
        nextLabel: 'Sair do Tour'
    },
    ]

    signal selectUploadFolder(string folderPath)
    signal logout()

    function openUploadFolderDialog() {
        uploadFolderDialog.open();
    }

    function setFolderPath(folderPath) {
        uploadFolderPath = folderPath;
    }

    function showTourNotification() {
        tourNotificationModal.open();
    }

    id: root

    Tour {
        id: guidedTour
        steps: root.tourSteps
    }

    FileDialog {
        id: uploadFolderDialog
        title: 'Escolha o diretório de upload'
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            selectUploadFolder(uploadFolderDialog.fileUrl);
        }
    }

    DsModal {
        id: saveModal
        title: 'Download de Documentos'
        showSecondaryButton: true
        text: 'Você ainda não possui o módulo de serviço de Download de Documentos. Deseja continuar sem contratar o serviço?'
        secondaryActionLabel: 'Contratar'
        primaryActionLabel: 'Continuar'
        onPrimaryAction: saveModal.close()
        onSecondaryAction: saveModal.close()
    }

    DsModal {
        id: tourNotificationModal
        title: 'Configurando o Synca'
        showSecondaryButton: true
        text: 'Seja bem-vindo ao Synca! Para começar, mostraremos à você nossas funcionalidades e como melhor usá-las para configurar e acompanhar o funcionamento do aplicativo.'
        secondaryActionLabel: 'Sair'
        primaryActionLabel: 'Começar o Tour'
        onPrimaryAction: {
            tourNotificationModal.close();
            guidedTour.startTour();
        }
        onSecondaryAction: tourNotificationModal.close()
    }

    Item {
        id: content

        anchors {
            fill: parent
            topMargin: 24
            rightMargin: 32
            bottomMargin: 42
            leftMargin: 32
        }

        Header {
            id: header
            onLogout: {
                root.logout();
            }
        }

        DsText {
            id: title
            text: 'Configurar integração'
            fontSize: 24
            font.weight: 'Bold'
            lineHeight: 32
            color: Colors.BRAND_TERTIARY_DEFAULT

            anchors {
                top: header.bottom
                topMargin: 32
            }
        }

        UploadSection {
            id: uploadSection
            folderPath: uploadFolderPath

            anchors {
                top: title.bottom
                topMargin: 16
            }

            onOpenDialog: openUploadFolderDialog()
        }

        DownloadSection {
            id: downloadSection

            anchors {
                top: uploadSection.bottom
                topMargin: 8
            }
        }

        DsButton {
            id: btnTour
            text: 'Tour do App'
            type: DsButton.Types.Inline
            anchors {
                left: parent.left
                top: downloadSection.bottom
                topMargin: 16
            }
            onClicked: guidedTour.startTour()
        }

        DsButton {
            id: btnSave
            text: 'Salvar'
            type: DsButton.Types.Special
            enabled: uploadFolderPath ? true : false
            anchors {
                right: parent.right
                top: downloadSection.bottom
                topMargin: 16
            }
            onClicked: saveModal.open()
        }
    }
}
