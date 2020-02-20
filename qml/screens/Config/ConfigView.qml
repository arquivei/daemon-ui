import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../components'
import './partials'
import '../../constants/colors.js' as Colors
import '../../helpers/factory.js' as Factory

Page {
    property bool showReturnAction
    property bool hasBeenEdited
    property bool isLoading: false
    property string uploadFolderPath
    property var tourSteps: [
    {
        id: 'step1',
        ref: uploadSection,
        parent: content,
        title: 'Configurar Upload',
        description: 'Clique em selecionar pasta para configurar o envio de documentos para a plataforma Arquivei.',
        chipInfo: '01/02',
        position: {
            top: uploadSection.bottom,
            topMargin: 8,
            left: uploadSection.left
        },
        nextLabel: 'Avançar'
    },
    {
        id: 'step2',
        ref: btnSave,
        parent: content,
        title: 'Finalizar Configuração',
        description: 'Ao selecionar a pasta de Upload, você deverá clicar em "Salvar" para prosseguir.',
        chipInfo: '02/02',
        position: {
            bottom: btnSave.top,
            bottomMargin: 8,
            right: btnSave.right
        },
        prevLabel: 'Voltar',
        nextLabel: 'Próximo'
    }
    ]

    signal saveConfigs(string uploadFolder)
    signal validateFolder(string folder)
    signal returnToMain()
    signal logout()

    function openUploadFolderDialog() {
        uploadFolderDialog.open();
    }

    function setUploadFolder(folder) {
        uploadFolderPath = folder;
    }

    function toggleLoading() {
        isLoading = !isLoading;
    }

    function openErrorDialog(errorTitle, errorMessage) {
        errorModal.title = errorTitle;
        errorModal.text = errorMessage;
        errorModal.open();
    }

    function showTourNotification() {
        tourNotificationModal.open();
    }

    id: root

    Tour {
        id: guidedTour
        steps: root.tourSteps
        onStepsCompleted: tourCompletedModal.open()
    }

    FileDialog {
        id: uploadFolderDialog
        title: 'Escolha o diretório de upload'
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            validateFolder(uploadFolderDialog.fileUrl);
        }
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
            guidedTour.start();
        }
        onSecondaryAction: tourNotificationModal.close()
    }

    DsModal {
        id: notSavedChangesAlertModal
        title: 'Alteração não salva'
        showSecondaryButton: true
        text: 'Você realizou a alteração da pasta de upload mas não salvou a alteração. Deseja voltar sem salvar?'
        secondaryActionLabel: 'Fechar'
        primaryActionLabel: 'Sim'
        onPrimaryAction: {
            notSavedChangesAlertModal.close();
            returnToMain();
        }
        onSecondaryAction: notSavedChangesAlertModal.close()
    }

    DsModal {
        id: tourCompletedModal
        title: 'Tour finalizado'
        text: 'Agora você já sabe como configurar a sua integração, selecionando as pastas de Upload e Download (se disponível). Parabéns!'
        primaryActionLabel: 'Sair do Tour'
        onPrimaryAction: {
            tourCompletedModal.close();
        }
    }

    DsModal {
        id: errorModal
        title: 'Ocorreu um Erro'
        primaryActionLabel: 'Entendi'
        onPrimaryAction: {
            errorModal.close();
        }
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
            onTourStart: {
                guidedTour.start();
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

//        DownloadSection {
//            id: downloadSection

//            anchors {
//                top: uploadSection.bottom
//                topMargin: 8
//            }
//        }

        Loader {
            id: returnButtonLoader
            sourceComponent: showReturnAction ? Factory.createPartialFragment('Config', 'ReturnButton') : null
            anchors {
                left: content.left
                bottom: content.bottom
            }
        }

        DsButton {
            id: btnSave
            text: 'Salvar'
            loadingText: 'Salvando...'
            type: DsButton.Types.Special
            enabled: hasBeenEdited ? true : false
            isLoading: root.isLoading
            anchors {
                right: content.right
                bottom: content.bottom
            }
            onClicked: saveConfigs(uploadFolderPath)
        }
    }
}
