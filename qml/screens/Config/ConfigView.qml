import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../components'
import './partials'
import '../../constants/colors.js' as Colors
import '../../constants/addresses.js' as Address
import '../../constants/texts.js' as Texts
import '../../helpers/factory.js' as Factory
import '../../lib/google-analytics.js' as GA

Page {
    property bool showReturnAction
    property bool hasBeenEdited
    property bool isLoading: false
    property bool canDownload
    property string userEmail
    property string macAddress
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
        description: 'Primeiro, você pode escolher a pasta onde estão os arquivos XML/ZIP que serão enviados para o Arquivei.',
        chipInfo: '01/03',
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
        description: 'Caso tenha o Download, selecione a pasta para configurar onde serão baixados os documentos do Arquivei para seu computador.',
        chipInfo: '02/03',
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
        description: 'Depois da configuração, é só clicar em Salvar. Vamos lá?',
        customWidth: 244,
        chipInfo: '03/03',
        position: {
            bottom: btnSave.top,
            bottomMargin: 8,
            right: btnSave.right
        },
        prevLabel: 'Voltar',
        nextLabel: 'Finalizar'
    }
    ]

    signal saveConfigs(string uploadFolder, string downloadFolder)
    signal selectDownloadFolder(string folder)
    signal selectUploadFolder(string folder)
    signal returnToMain()
    signal logout()

    function setDownloadFolder(folder) {
        downloadFolderPath = folder;
        changeDownloadConfigModal.open();
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

    // Comparação de pastas teve que ser dessa forma por causa dos prefixos do
    // sistema de arquivos que variam de acordo com SO
    function isSameFolder(selectedFolder, comparedFolder) {
        const pattern = new RegExp(`${comparedFolder}$`);
        return pattern.test(selectedFolder);
    }

    id: root

    Component.onCompleted: {
        GA.setClientId(macAddress);
        GA.trackScreen(GA.ScreenNames.CONFIG);
    }

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
            if (downloadFolderPath && isSameFolder(url, downloadFolderPath)) {
                const { TITLE, DESCRIPTION } = Texts.Config.Modals.SameAsDownloadFolderError;
                openErrorDialog(TITLE, DESCRIPTION);
                return;
            }
            selectUploadFolder(url);
        }
    }

    FileDialog {
        id: downloadFolderDialog
        title: Texts.Config.FileDialogs.DownloadFolder.TITLE
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            const url = downloadFolderDialog.fileUrl.toString();
            if (uploadFolderPath && isSameFolder(url, uploadFolderPath)) {
                const { TITLE, DESCRIPTION } = Texts.Config.Modals.SameAsUploadFolderError;
                openErrorDialog(TITLE, DESCRIPTION);
                return;
            }

            selectDownloadFolder(url);
        }
    }

    DsModal {
        id: tourNotificationModal
        title: Texts.Config.Modals.BeginTour.TITLE
        showSecondaryButton: true
        text: Texts.Config.Modals.BeginTour.DESCRIPTION
        secondaryActionLabel: Texts.Config.Modals.BeginTour.SECONDARY
        primaryActionLabel: Texts.Config.Modals.BeginTour.PRIMARY
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
            changeDownloadConfigModal.close();
        }
        onSecondaryAction: {
            changeDownloadConfigModal.close();
            Qt.openUrlExternally(webDetailLink);
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
                    onTriggered: {
                        GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.CLICKED_ON_ACCESS_PLATFORM);
                        Qt.openUrlExternally(webDetailLink);
                    }
                },
                Action {
                    id: tourAction
                    text: Texts.General.Menu.TOUR
                    onTriggered: {
                        GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.CLICKED_ON_TOUR_CONFIG);
                        guidedTour.start();
                    }
                },
                Action {
                    id: aboutAction
                    text: Texts.General.Menu.ABOUT
                    onTriggered: {
                        GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.CLICKED_ON_ABOUT);
                        Qt.openUrlExternally(Address.ABOUT_URL);
                    }
                },
                Action {
                    id: logsAction
                    text: Texts.General.Menu.LOGS
                    onTriggered: {
                        GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.CLICKED_ON_LOGS);
                        Qt.openUrlExternally(logsPath);
                    }
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

            onOpenDialog: uploadFolderDialog.open()
        }

        Loader {
            id: downloadSection
            sourceComponent: canDownload ? Factory.createPartialFragment('Config', 'DownloadSection') : Factory.createPartialFragment('Config', 'DownloadSectionSoon')
            width: parent.width
            anchors {
                top: uploadSection.bottom
                topMargin: 8
            }
        }

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
            onClicked: saveConfigs(uploadFolderPath, downloadFolderPath)
        }
    }
}
