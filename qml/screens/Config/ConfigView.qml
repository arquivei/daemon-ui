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
    property bool hasDownload
    property string userEmail
    property string uploadFolderPath
    property string downloadFolderPath
    property string webDetailLink
    property string logsPath
    property var tourSteps: [
    {
        id: 'step1',
        ref: uploadSection,
        parent: content,
        title: 'Configurar Upload',
        description: 'Primeiro, você deve escolher a pasta onde estão os documentos que serão enviados para o Arquivei.',
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
        description: 'Depois de escolher a pasta, é só clicar em Salvar. Vamos lá?',
        chipInfo: '02/02',
        position: {
            bottom: btnSave.top,
            bottomMargin: 8,
            right: btnSave.right
        },
        prevLabel: 'Voltar',
        nextLabel: 'Finalizar'
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
    }

    FileDialog {
        id: uploadFolderDialog
        title: Texts.Config.FileDialogs.UploadFolder.TITLE
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            const url = uploadFolderDialog.fileUrl.toString();
            validateFolder(url);
        }
    }

    FileDialog {
        id: downloadFolderDialog
        title: Texts.Config.FileDialogs.DownloadFolder.TITLE
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            const url = downloadFolderDialog.fileUrl.toString();
            if (downloadFolderPath) {
                changeDownloadConfigModal.open()
            } else {
                console.log('validate and select download folder...')
            }
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
        id: changeDownloadConfigModal
        title: Texts.Config.Modals.ChangeDownloadConfig.TITLE
        showSecondaryButton: true
        text: Texts.Config.Modals.ChangeDownloadConfig.DESCRIPTION
        secondaryActionLabel: Texts.Config.Modals.ChangeDownloadConfig.SECONDARY
        primaryActionLabel: Texts.Config.Modals.ChangeDownloadConfig.PRIMARY
        onPrimaryAction: {
            console.log('validate and select download folder...')
            changeDownloadConfigModal.close();
        }
        onSecondaryAction: {
            console.log('validate, select download folder and go to web config')
            changeDownloadConfigModal.close();
        }
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
            bottomMargin: 32
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
//            folderPath: downloadFolderPath
//            title: Texts.Config.DOWNLOAD_SECTION_TITLE
//            description: Texts.Config.DOWNLOAD_SECTION_DESCRIPTION
//            visible: hasDownload
//            anchors {
//                top: uploadSection.bottom
//                topMargin: 8
//            }

//            onOpenDialog: downloadFolderDialog.open()
//        }

//        DownloadSectionHire {
//            id: downloadSectionHire
//            title: Texts.Config.DOWNLOAD_SECTION_TITLE
//            description: Texts.Config.DOWNLOAD_SECTION_HIRE_DESCRIPTION
//            hireDownloadUrl: Address.HIRE_DOWNLOAD_URL
//            visible: !hasDownload
//            anchors {
//                top: uploadSection.bottom
//                topMargin: 8
//            }
//        }

//        DownloadSectionSoon {
//            id: downloadSection
//            title: Texts.Config.DOWNLOAD_SECTION_TITLE_SOON
//            description: Texts.Config.DOWNLOAD_SECTION_DESCRIPTION_SOON

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
