import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../components'
import './partials'
import '../../constants/colors.js' as Colors
import '../../constants/addresses.js' as Address
import '../../constants/texts.js' as Texts
import '../../helpers/factory.js' as Factory

Page {
    property bool showReturnAction
    property bool hasBeenEdited
    property bool isLoading: false
    property string userEmail
    property string uploadFolderPath
    property string webDetailLink
    property string logsPath
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
            const url = uploadFolderDialog.fileUrl.toString();
            validateFolder(url);
        }
    }

    DsModal {
        id: tourNotificationModal
        title: Texts.Config.Modals.BeginTour.TITLE
        showSecondaryButton: true
        text: Texts.Config.Modals.BeginTour.DESCRIPTION
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
        title: Texts.Config.Modals.NotSavedModifications.TITLE
        showSecondaryButton: true
        text: Texts.Config.Modals.NotSavedModifications.DESCRIPTION
        secondaryActionLabel: Texts.Config.Modals.NotSavedModifications.SECONDARY
        primaryActionLabel: Texts.Config.Modals.NotSavedModifications.PRIMARY
        onPrimaryAction: {
            notSavedChangesAlertModal.close();
            returnToMain();
        }
        onSecondaryAction: notSavedChangesAlertModal.close()
    }

    DsModal {
        id: logoutModal
        title: Texts.General.Modals.LogoutAlert.TITLE
        showSecondaryButton: true
        text: Texts.General.Modals.LogoutAlert.DESCRIPTION
        secondaryActionLabel: Texts.General.Modals.LogoutAlert.SECONDARY
        primaryActionLabel: Texts.General.Modals.LogoutAlert.PRIMARY
        onPrimaryAction: {
            logoutModal.close();
        }
        onSecondaryAction: {
            logout();
        }
    }

    DsModal {
        id: tourCompletedModal
        title: Texts.Config.Modals.FinishTour.TITLE
        text: Texts.Config.Modals.FinishTour.DESCRIPTION
        primaryActionLabel: Texts.Config.Modals.FinishTour.PRIMARY
        onPrimaryAction: {
            tourCompletedModal.close();
        }
    }

    DsModal {
        id: errorModal
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
            userEmail: root.userEmail
            current: configAction
            alertAction: logoutAction
            actions: [
                Action {
                    id: configAction
                    text: Texts.General.Menu.CONFIG
                },
                Action {
                    id: accessPlatformAction
                    text: Texts.General.Menu.ACCESS_PLATFORM
                    onTriggered: Qt.openUrlExternally(webDetailLink)
                },
                Action {
                    id: tourAction
                    text: Texts.General.Menu.TOUR
                    onTriggered: guidedTour.start()
                },
                Action {
                    id: aboutAction
                    text: Texts.General.Menu.ABOUT
                    onTriggered: Qt.openUrlExternally(Address.ABOUT_URL)
                },
                Action {
                    id: logsAction
                    text: Texts.General.Menu.LOGS
                    onTriggered: Qt.openUrlExternally(logsPath)
                },
                Action {
                    id: logoutAction
                    text: Texts.General.Menu.LOGOUT
                    onTriggered: logoutModal.open()
                }
            ]
        }

        DsText {
            id: title
            text: Texts.Config.TITLE
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
            title: Texts.Config.UPLOAD_SECTION_TITLE
            description: Texts.Config.UPLOAD_SECTION_DESCRIPTION

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
