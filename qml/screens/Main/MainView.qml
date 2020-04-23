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

Page {
    property string userEmail
    property string macAddress
    property string computerName
    property string webDetailLink
    property string logsPath
    property string uploadFolderPath
    property string downloadFolderPath
    property bool canDownload
    property bool isMainTourViewed

    property string uploadProcessingStatus
    property int uploadTotal: 0
    property int uploadTotalSent: 0
    property bool uploadHasDocumentError: false

    property string downloadProcessingStatus
    property int downloadTotal: 0

    property var tourSteps: [
    {
        id: 'step1',
        ref: title,
        parent: content,
        title: 'Nome da máquina',
        description: 'Este é o nome da máquina na qual este software está instalado.',
        chipInfo: '01/05',
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
        chipInfo: '02/05',
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
        chipInfo: '03/05',
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
        ref: btnDetails,
        parent: content,
        title: 'Detalhes do processamento',
        description: 'Clicando nesse botão você poderá acompanhar todos os detalhes do processamento direto no Arquivei.',
        chipInfo: '04/05',
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
        id: 'step5',
        ref: menu,
        parent: content,
        title: 'Menu do usuário',
        description: 'Neste menu você tem acesso às configurações, aos logs da aplicação e ao tour caso tenha ficado alguma dúvida.',
        chipInfo: '05/05',
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

    signal goToConfig()
    signal mainTourViewed()
    signal logout()

    function setUploadProcessingStatus(processingStatus, total, totalSent, hasDocumentError) {
        uploadProcessingStatus = processingStatus;
        uploadTotalSent = totalSent;
        uploadTotal = total;
        uploadHasDocumentError = hasDocumentError;
    }

    function setDownloadProcessingStatus(processingStatus, totalDownloaded) {
        downloadProcessingStatus = processingStatus;
        downloadTotal = totalDownloaded;
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

    function getDownloadComponent() {
        if (!canDownload) {
            // Quando feature estiver finalizada, substituir pela seção de contratação do Download
            return Factory.createPartialFragment('Main', 'DownloadSectionSoon');
        }

        if (!downloadFolderPath) {
            return Factory.createPartialFragment('Main', 'DownloadNotConfigured');
        }

        return Factory.createPartialFragment('Main', 'DownloadSection');
    }

    id: root

    Component.onCompleted: {
        GA.setClientId(macAddress);
        GA.trackScreen(GA.ScreenNames.MAIN);
    }

    Tour {
        id: guidedTour
        steps: root.tourSteps

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

    Item {
        id: content

        anchors {
            fill: parent
            topMargin: 24
            rightMargin: 32
            bottomMargin: 46
            leftMargin: 32
        }

        Image {
            id: imageLogo
            source: "qrc:/images/arquivei-icon.svg"
            fillMode: Image.PreserveAspectFit

            anchors {
                top: parent.top
                topMargin: 8
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
                fontSize: 24
                font.weight: 'Bold'
                lineHeight: 32
                color: Colors.BRAND_TERTIARY_DEFAULT
            }

            anchors {
                top: imageLogo.bottom
                topMargin: 32
            }
        }

        TourStepWrapper {
            id: connectionStatus

            ConnectionStatus {
                id: connectionStatusContent
            }

            anchors {
                verticalCenter: title.verticalCenter
                verticalCenterOffset: 4
                right: content.right
            }
        }

        Loader {
            id: uploadSection
            sourceComponent: uploadFolderPath ? Factory.createPartialFragment('Main', 'UploadSection') : Factory.createPartialFragment('Main', 'UploadNotConfigured')
            width: parent.width
            anchors {
                top: title.bottom
                topMargin: 16
            }
        }

        Loader {
            id: downloadSection
            sourceComponent: getDownloadComponent()
            width: parent.width
            anchors {
                top: uploadSection.bottom
                topMargin: uploadFolderPath ? 8 : 14
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
