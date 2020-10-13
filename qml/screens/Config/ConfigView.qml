import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../helpers/validator.js' as Validator
import '../../constants/colors.js' as Colors
import '../../constants/addresses.js' as Address
import '../../constants/texts.js' as Texts
import '../../lib/google-analytics.js' as GA
import '../../components'
import './partials'

Page {
    id: root

    property bool canDownload
    property bool hasUnsavedChanges
    property bool isConfigTourViewed
    property bool showReturnAction
    property string downloadFolder
    property string logsPath
    property string macAddress
    property string userEmail
    property string webDetailLink
    property var uploadFolders

    QtObject {
        id: priv

        property bool isSavingConfigs: false
        property bool isVerifyingDownload: false
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
                ref: downloadSectionLoader,
                parent: content,
                title: 'Configurar Download',
                description: 'Caso tenha o Download, selecione a pasta para configurar onde serão baixados os documentos do Arquivei para seu computador.',
                chipInfo: '02/03',
                position: {
                    bottom: downloadSectionLoader.top,
                    bottomMargin: 8,
                    left: downloadSectionLoader.left
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

        function displayDownloadSection() {
            if (canDownload) {
                downloadSectionLoader.setSource('partials/DownloadFolderSection.qml', {
                    title: Texts.General.DOWNLOAD_SECTION_TITLE,
                    description: Texts.Config.DOWNLOAD_SECTION_DESCRIPTION,
                    folder: downloadFolder
                })
            } else {
                downloadSectionLoader.setSource('../partials/DownloadPurchaseSection.qml', {
                    isVerifying: isVerifyingDownload,
                    title: Texts.General.DOWNLOAD_SECTION_TITLE,
                    description: Texts.General.DOWNLOAD_SECTION_PURCHASE_DESCRIPTION
                })
            }
        }

        function displayReturnButton() {
            if (showReturnAction) {
                returnButtonLoader.setSource('../../components/DsButton.qml', {
                     text: 'Voltar',
                     type: DsButton.Types.Inline
                })
            } else {
                returnButtonLoader.source = ''
            }
        }

        function displayUnsavedChangesAlert() {
            if (hasUnsavedChanges) {
                unsavedChangesAlertLoader.setSource('partials/UnsavedChangesAlert.qml', {
                    message: 'Alterações não salvas'
                })
            } else {
                unsavedChangesAlertLoader.source = ''
            }
        }

        onIsVerifyingDownloadChanged: {
            if (!canDownload) {
                downloadSectionLoader.item.isVerifying = isVerifyingDownload
            }
        }
    }

    signal checkDownloadPermission()
    signal configTourViewed()
    signal goToManageUpload()
    signal logout()
    signal returnToMain()
    signal saveConfigs(var uploadFolders, string downloadFolder)
    signal selectDownloadFolder(string folder)
    signal selectUploadFolder(string folder)

    function openDownloadNotAllowedModal() {
        downloadNotAllowedModal.open()
    }

    function openGenericErrorModal(errorTitle, errorMessage) {
        genericErrorModal.title = errorTitle;
        genericErrorModal.text = errorMessage;
        genericErrorModal.open();
    }

    function setDownloadFolder(folder) {
        downloadFolder = folder;
        changeDownloadConfigModal.open();
    }

    function setUnsavedChanges(hasChanges) {
        hasUnsavedChanges = hasChanges;
    }

    function setUploadFolder(folder) {
        uploadFolders = [folder];
    }

    function showTourNotification() {
        tourNotificationModal.open();
    }

    function toggleIsSavingConfigs() {
        priv.isSavingConfigs = !priv.isSavingConfigs;
    }

    function toggleIsVerifyingDownload() {
        priv.isVerifyingDownload = !priv.isVerifyingDownload
    }

    Component.onCompleted: {
        GA.setClientId(macAddress);
        GA.trackScreen(GA.ScreenNames.CONFIG);
        priv.displayDownloadSection();
        priv.displayReturnButton();
        priv.displayUnsavedChangesAlert();
    }

    onCanDownloadChanged: {
        if (!canDownload) {
            downloadUnpurshasedModal.open();
        }

        priv.displayDownloadSection();
    }

    onDownloadFolderChanged: {
        if (canDownload && downloadSectionLoader.item) {
            downloadSectionLoader.item.folder = downloadFolder
        }
    }

    onHasUnsavedChangesChanged: {
        priv.displayUnsavedChangesAlert();
    }

    onShowReturnActionChanged: {
        priv.displayDownloadSection();
    }

    Tour {
        id: guidedTour
        steps: priv.tourSteps

        onStarted: {
            if (!isConfigTourViewed) {
                root.configTourViewed()
            }
        }
    }

    FileDialog {
        id: uploadFolderDialog
        title: Texts.Config.FileDialogs.UploadFolder.TITLE
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            const url = uploadFolderDialog.fileUrl.toString();
            if (Validator.isSameFolder(url, downloadFolder)) {
                const { TITLE, DESCRIPTION } = Texts.Config.Modals.SameAsDownloadFolderError;
                openGenericErrorModal(TITLE, DESCRIPTION);
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

            if (uploadFolders && uploadFolders.some(folder => Validator.isSameFolder(url, folder))) {
                const { TITLE, DESCRIPTION } = Texts.Config.Modals.SameAsUploadFolderError;
                openGenericErrorModal(TITLE, DESCRIPTION);
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
        onSecondaryAction: {
            root.configTourViewed()
            tourNotificationModal.close()
        }
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
        id: downloadNotAllowedModal
        title: Texts.General.Modals.DownloadNotAllowed.TITLE
        showSecondaryButton: true
        text: Texts.General.Modals.DownloadNotAllowed.DESCRIPTION
        secondaryActionLabel: Texts.General.Modals.DownloadNotAllowed.SECONDARY
        primaryActionLabel: Texts.General.Modals.DownloadNotAllowed.PRIMARY
        onPrimaryAction: {
            Qt.openUrlExternally(Address.PURCHASE_DOWNLOAD_URL);
            downloadNotAllowedModal.close();
        }
        onSecondaryAction: {
            downloadNotAllowedModal.close();
        }
    }

    DsModal {
        id: downloadUnpurshasedModal
        title: Texts.General.Modals.DownloadUnpurshased.TITLE
        showSecondaryButton: true
        text: Texts.General.Modals.DownloadUnpurshased.DESCRIPTION
        secondaryActionLabel: Texts.General.Modals.DownloadUnpurshased.SECONDARY
        primaryActionLabel: Texts.General.Modals.DownloadUnpurshased.PRIMARY
        onPrimaryAction: {
            Qt.openUrlExternally(Address.PURCHASE_DOWNLOAD_URL);
            downloadUnpurshasedModal.close();
        }
        onSecondaryAction: {
            downloadUnpurshasedModal.close();
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
        id: genericErrorModal
        primaryActionLabel: 'Entendi'
        onPrimaryAction: {
            genericErrorModal.close();
        }
    }

    Item {
        id: content

        anchors {
            fill: parent
            margins: 32
            bottomMargin: 40
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
            fontSize: 16
            font.weight: 'Bold'
            lineHeight: 19
            color: Colors.BRAND_TERTIARY_DEFAULT

            anchors {
                top: header.bottom
                topMargin: 52
            }
        }

        Loader {
            id: unsavedChangesAlertLoader

            anchors {
                bottom: title.bottom
                right: parent.right
            }
        }

        UploadFolderSection {
            id: uploadSection
            folders: uploadFolders
            title: Texts.General.UPLOAD_SECTION_TITLE
            description: Texts.Config.UPLOAD_SECTION_DESCRIPTION

            anchors {
                top: title.bottom
                topMargin: 24
            }

            onSelectFolderClicked: uploadFolderDialog.open()
            onSettingsClicked: goToManageUpload()
        }

        Loader {
            id: downloadSectionLoader

            width: parent.width
            anchors {
                top: uploadSection.bottom
                topMargin: 8
            }

            Connections {
                id: downloadPurchaseConnection

                target: canDownload ? null : downloadSectionLoader.item
                onPurchase: {
                    Qt.openUrlExternally(Address.PURCHASE_DOWNLOAD_URL);
                }
                onVerify: {
                    checkDownloadPermission();
                }
            }

            Connections {
                id: downloadConfigConnection

                target: canDownload ? downloadSectionLoader.item : null
                onSelectFolderClicked: downloadFolderDialog.open()
            }
        }

        Loader {
            id: returnButtonLoader

            anchors {
                left: content.left
                bottom: content.bottom
            }

            Connections {
                id: returnButtonConnection

                target: showReturnAction ? returnButtonLoader.item : null
                onClicked: {
                    if (hasUnsavedChanges) {
                        notSavedChangesAlertModal.open();
                    } else {
                        returnToMain();
                    }
                }
            }
        }

        DsButton {
            id: btnSave
            text: 'Salvar'
            loadingText: 'Salvando...'
            type: DsButton.Types.Special
            enabled: hasUnsavedChanges ? true : false
            isLoading: priv.isSavingConfigs
            anchors {
                right: content.right
                bottom: content.bottom
            }
            onClicked: saveConfigs(uploadFolders, downloadFolder)
        }
    }
}
