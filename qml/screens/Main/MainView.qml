import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../components'
import './partials'
import '../../constants/colors.js' as Colors
import '../../constants/addresses.js' as Address
import '../../constants/texts.js' as Texts
import '../../lib/google-analytics.js' as GA
import '../../helpers/factory.js' as Factory
import '../../helpers/text-helper.js' as TextHelper

Page {
    id: root

    property string userEmail
    property string macAddress
    property string computerName
    property string webDetailLink
    property string logsPath
    property string downloadFolder
    property var uploadFolders
    property bool canDownload
    property bool isMainTourViewed

    QtObject {
        id: priv

        property bool isVerifyingDownload: false
        property bool uploadHasDocumentError: false
        property int uploadTotal: 0
        property int uploadTotalSent: 0
        property int downloadTotal: 0
        property string uploadProcessingStatus
        property string downloadProcessingStatus
        property var tourSteps: [
            {
                id: 'step1',
                ref: title,
                parent: content,
                title: 'Nome da máquina',
                description: 'Este é o nome da máquina na qual este software está instalado.',
                chipInfo: '01/06',
                position: {
                    top: title.bottom,
                    topMargin: 16,
                    left: title.left,
                    leftMargin: -8
                },
                nextLabel: 'Avançar'
            },
            {
                id: 'step2',
                ref: connectionStatus,
                parent: content,
                title: 'Status da integração',
                description: 'Aqui você verifica se o software está ou não conectado ao Arquivei. Com o status Online é possível enviar e baixar documentos.',
                chipInfo: '02/06',
                position: {
                    top: connectionStatus.bottom,
                    topMargin: 16,
                    right: connectionStatus.right,
                    rightMargin: -8
                },
                prevLabel: 'Voltar',
                nextLabel: 'Avançar'
            },
            {
                id: 'step3',
                ref: uploadSection,
                parent: content,
                title: 'Acompanhando o Upload',
                description: 'Neste espaço você poderá acompanhar se os arquivos XML e ZIP da pasta selecionada estão sendo lidos e enviados.',
                chipInfo: '03/06',
                customWidth: 240,
                position: {
                    top: uploadSection.bottom,
                    topMargin: 8,
                    left: uploadSection.left
                },
                prevLabel: 'Voltar',
                nextLabel: 'Avançar'
            },
            {
                id: 'step4',
                ref: downloadSectionLoader,
                parent: content,
                title: 'Acompanhando o Download',
                description: 'Neste espaço você poderá acompanhar se os documentos do Arquivei estão sendo baixados para seu computador.',
                chipInfo: '04/06',
                customWidth: 240,
                position: {
                    bottom: downloadSectionLoader.top,
                    bottomMargin: 8,
                    left: downloadSectionLoader.left
                },
                prevLabel: 'Voltar',
                nextLabel: 'Avançar'
            },
            {
                id: 'step5',
                ref: btnDetails,
                parent: content,
                title: 'Detalhes do processamento',
                description: 'Clicando nesse botão você poderá acompanhar todos os detalhes do processamento direto no Arquivei.',
                chipInfo: '05/06',
                customWidth: 260,
                position: {
                    bottom: btnDetails.top,
                    bottomMargin: 16,
                    right: btnDetails.right,
                    rightMargin: -8
                },
                prevLabel: 'Voltar',
                nextLabel: 'Avançar'
            },
            {
                id: 'step6',
                ref: menu,
                parent: content,
                title: 'Menu do usuário',
                description: 'Neste menu você tem acesso às configurações, aos logs da aplicação e ao tour caso tenha ficado alguma dúvida.',
                chipInfo: '06/06',
                customWidth: 260,
                position: {
                    top: menu.bottom,
                    topMargin: 16,
                    right: menu.right,
                    rightMargin: -8
                },
                prevLabel: 'Voltar',
                nextLabel: 'Finalizar'
            },
        ]

        function handleDownloadSectionDisplay() {
            if (canDownload && downloadFolder) {
               downloadSectionLoader.setSource('partials/DownloadSection.qml')
            } else if (canDownload) {
               downloadSectionLoader.setSource('partials/DownloadNotConfigured.qml')
            } else {
               downloadSectionLoader.setSource('../partials/DownloadPurchaseSection.qml', {
                   isVerifying: isVerifyingDownload,
                   title: Texts.General.DOWNLOAD_SECTION_TITLE,
                   description: Texts.General.DOWNLOAD_SECTION_PURCHASE_DESCRIPTION
               })
            }
        }

        onIsVerifyingDownloadChanged: {
            if (!canDownload) {
                downloadSectionLoader.item.isVerifying = isVerifyingDownload
            }
        }
    }

    signal goToConfig()
    signal goToManageUpload()
    signal mainTourViewed()
    signal checkDownloadPermission()
    signal logout()

    function setUploadProcessingStatus(processingStatus, total, totalSent, hasDocumentError) {
        priv.uploadProcessingStatus = processingStatus;
        priv.uploadTotalSent = totalSent;
        priv.uploadTotal = total;
        priv.uploadHasDocumentError = hasDocumentError;
    }

    function setDownloadProcessingStatus(processingStatus, totalDownloaded) {
        priv.downloadProcessingStatus = processingStatus;
        priv.downloadTotal = totalDownloaded;
    }

    function setConnectionStatus(isOnline) {
        connectionStatusContent.isOnline = isOnline;
        if (!isOnline) {
            connectionErrorModal.open();
        } else {
            connectionErrorModal.close();
        }
    }

    function showTourNotification() {
        tourNotificationModal.open();
    }

    function showNotAuthenticatedModal() {
        authenticationErrorModal.open();
    }

    function showFolderValidationErrorModal(errorTitle, errorMessage) {
        folderValidationErrorModal.title = errorTitle;
        folderValidationErrorModal.text = errorMessage;
        folderValidationErrorModal.open();
    }

    function toggleIsVerifyingDownload() {
        priv.isVerifyingDownload = !priv.isVerifyingDownload
    }

    function openGenericErrorModal(errorTitle, errorMessage) {
        genericErrorModal.title = errorTitle;
        genericErrorModal.text = errorMessage;
        genericErrorModal.open();
    }

    function openDownloadNotAllowedModal() {
        downloadNotAllowedModal.open()
    }

    Component.onCompleted: {
        GA.setClientId(macAddress);
        GA.trackScreen(GA.ScreenNames.MAIN);
        priv.handleDownloadSectionDisplay();
    }

    onCanDownloadChanged: {
        if (!canDownload) {
            GA.trackEvent(GA.EventCategories.DOWNLOAD, GA.EventActions.DOWNLOAD_UNPURSHASED);
            downloadUnpurshasedModal.open();
        }

        priv.handleDownloadSectionDisplay();
    }

    onUploadFoldersChanged: {
        if (!uploadFolders) {
            return;
        }

        const numOfFolderErrors = uploadFolders.filter(folder => folder.code).length;
        const numOfFolders = uploadFolders.length;

        if (!numOfFolderErrors) {
            singleUploadFolderErrorModal.close();
            multiUploadFolderErrorModal.close();
        }

        if (numOfFolders === 1 && uploadFolders[0].code) {
            singleUploadFolderErrorModal.open()
        }

        if (numOfFolders > 1 && numOfFolderErrors > 0) {
            multiUploadFolderErrorModal.text = TextHelper.fillStr(Texts.Main.Modals.MultiUploadFolderError.DESCRIPTION, numOfFolderErrors, numOfFolders);
            multiUploadFolderErrorModal.open()
        }
    }

    Tour {
        id: guidedTour
        steps: priv.tourSteps

        onStarted: {
            if (!isMainTourViewed) {
                root.mainTourViewed()
            }
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
        id: folderValidationErrorModal
        showSecondaryButton: true
        secondaryActionLabel: 'Fechar'
        primaryActionLabel: 'Ir para Configurações'
        onPrimaryAction: {
            folderValidationErrorModal.close();
            goToConfig();
        }
        onSecondaryAction: {
            folderValidationErrorModal.close();
        }
    }

    DsModal {
        id: singleUploadFolderErrorModal
        title: Texts.Main.Modals.SingleUploadFolderError.TITLE
        text: Texts.Main.Modals.SingleUploadFolderError.DESCRIPTION
        showSecondaryButton: true
        secondaryActionLabel: 'Fechar'
        primaryActionLabel: 'Corrigir agora'
        onPrimaryAction: {
            goToConfig();
        }
        onSecondaryAction: {
            singleUploadFolderErrorModal.close();
        }
    }

    DsModal {
        id: multiUploadFolderErrorModal
        title: Texts.Main.Modals.MultiUploadFolderError.TITLE
        showSecondaryButton: true
        secondaryActionLabel: 'Fechar'
        primaryActionLabel: 'Corrigir agora'
        onPrimaryAction: {
            goToManageUpload();
        }
        onSecondaryAction: {
            multiUploadFolderErrorModal.close();
        }
    }

    DsModal {
        id: authenticationErrorModal
        title: Texts.Main.Modals.AuthenticationLost.TITLE
        text: Texts.Main.Modals.AuthenticationLost.DESCRIPTION
        primaryActionLabel: Texts.Main.Modals.AuthenticationLost.PRIMARY
        onPrimaryAction: {
            authenticationErrorModal.close();
            logout();
        }
    }

    DsModal {
        id: connectionErrorModal
        showActions: false
        title: Texts.Main.Modals.ConnectionError.TITLE
        text: Texts.Main.Modals.ConnectionError.DESCRIPTION
        titleColor: Colors.FEEDBACK_ERROR_DEFAULT
    }

    DsModal {
        id: tourNotificationModal
        title: Texts.Main.Modals.BeginTour.TITLE
        showSecondaryButton: true
        text: Texts.Main.Modals.BeginTour.DESCRIPTION
        secondaryActionLabel: Texts.Main.Modals.BeginTour.SECONDARY
        primaryActionLabel: Texts.Main.Modals.BeginTour.PRIMARY
        onPrimaryAction: {
            tourNotificationModal.close();
            guidedTour.start();
        }
        onSecondaryAction: {
            root.mainTourViewed();
            tourNotificationModal.close();
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

        Image {
            id: imageLogo
            source: "qrc:/images/sincroniza-notas-logo.svg"
            fillMode: Image.PreserveAspectFit

            anchors {
                top: parent.top
                left: parent.left
            }
        }

        TourStepWrapper {
            id: menu

            DsDropDownMenu {
                id: menuContent
                menuText: root.userEmail
                alertAction: logoutAction
                isBlocked: parent.isBlocked
                actions: [
                    Action {
                        id: configAction
                        text: Texts.General.Menu.CONFIG
                        onTriggered: root.goToConfig();
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
                            GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.CLICKED_ON_TOUR_MAIN);
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

            anchors {
                top: parent.top
                right: parent.right
            }
        }

        TourStepWrapper {
            id: title

            DsText {
                id: titleContent
                text: root.computerName
                fontSize: 16
                font.weight: 'Bold'
                lineHeight: 19
                color: Colors.BRAND_TERTIARY_DEFAULT
            }

            anchors {
                top: imageLogo.bottom
                topMargin: 52
            }
        }

        TourStepWrapper {
            id: connectionStatus

            ConnectionStatus {
                id: connectionStatusContent
            }

            anchors {
                top: imageLogo.bottom
                topMargin: 50
                right: content.right
            }
        }

        Loader {
            id: uploadSection
            sourceComponent: uploadFolders && uploadFolders.length ? Factory.createPartialFragment('Main', 'UploadSection') : Factory.createPartialFragment('Main', 'UploadNotConfigured')
            width: parent.width
            anchors {
                top: title.bottom
                topMargin: 24
            }
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
                    GA.trackEvent(GA.EventCategories.DOWNLOAD, GA.EventActions.CLICKED_ON_PURCHASE_DOWNLOAD);
                    Qt.openUrlExternally(Address.PURCHASE_DOWNLOAD_URL);
                }
                onVerify: {
                    checkDownloadPermission();
                }
            }
        }

        TourStepWrapper {
            id: btnDetails

            DsButton {
                id: btnDetailsContent
                text: Texts.Main.WEB_DETAILS_BUTTON_LABEL
                isBlocked: parent.isBlocked
                onClicked: {
                    GA.trackEvent(GA.EventCategories.NAVIGATION, GA.EventActions.CLICKED_ON_DETAILS_BUTTON);
                    Qt.openUrlExternally(webDetailLink);
                }
            }

            anchors {
                right: content.right
                bottom: content.bottom
            }
        }
    }
}
