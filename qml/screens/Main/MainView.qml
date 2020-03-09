import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../components'
import './partials'
import '../../constants/colors.js' as Colors
import '../../constants/addresses.js' as Address
import '../../constants/texts.js' as Texts

Page {
    property string userEmail
    property string computerName
    property string webDetailLink
    property string logsPath
    property bool hasDownload

    signal goToConfig()
    signal logout()

    function setProcessingStatus(processingStatus, total, totalSent, hasDocumentError) {
        uploadSection.processingStatus = processingStatus;
        uploadSection.totalSent = totalSent;
        uploadSection.total = total;
        uploadSection.hasDocumentError = hasDocumentError;
    }

    function setConnectionStatus(isOnline) {
        connectionStatus.isOnline = isOnline;
        if (!isOnline) {
            connectionErrorModal.open();
        } else {
            connectionErrorModal.close();
        }
    }

    function showNotAuthenticatedModal() {
        authenticationErrorModal.open();
    }

    function showFolderValidationErrorModal(errorTitle, errorMessage) {
        folderValidationErrorModal.title = errorTitle;
        folderValidationErrorModal.text = errorMessage;
        folderValidationErrorModal.open();
    }

    id: root

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

    Item {
        id: content

        anchors {
            fill: parent
            topMargin: 24
            rightMargin: 32
            bottomMargin: 40
            leftMargin: 32
        }

        Header {
            id: header
            userEmail: root.userEmail
            alertAction: logoutAction
            actions: [
                Action {
                    id: configAction
                    text: Texts.General.Menu.CONFIG
                    onTriggered: root.goToConfig();
                },
                Action {
                    id: accessPlatformAction
                    text: Texts.General.Menu.ACCESS_PLATFORM
                    onTriggered: Qt.openUrlExternally(webDetailLink)
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
            text: root.computerName
            fontSize: 24
            font.weight: 'Bold'
            lineHeight: 32
            color: Colors.BRAND_TERTIARY_DEFAULT

            anchors {
                top: header.bottom
                topMargin: 32
            }
        }

        ConnectionStatus {
            id: connectionStatus

            anchors {
                verticalCenter: title.verticalCenter
                verticalCenterOffset: 4
                right: content.right
            }
        }

        UploadSection {
            id: uploadSection
            title: Texts.Main.UPLOAD_SECTION_TITLE
            description: Texts.Main.UPLOAD_SECTION_DESCRIPTION
            successWarningTitle: Texts.Main.SUCCESS_SENDING_WARNING_TITLE
            successWarningDescription: Texts.Main.SUCCESS_SENDING_WARNING_DESCRIPTION

            anchors {
                top: title.bottom
                topMargin: 16
            }
        }

        DownloadSectionSoon {
            id: downloadSection
            title: Texts.Main.DOWNLOAD_SECTION_TITLE_SOON
            description: Texts.Main.DOWNLOAD_SECTION_DESCRIPTION_SOON

            anchors {
                top: uploadSection.bottom
                topMargin: 8
            }
        }

//        DownloadSection {
//            id: downloadSection
//            title: Texts.Main.DOWNLOAD_SECTION_TITLE
//            description: Texts.Main.DOWNLOAD_SECTION_DESCRIPTION
//            visible: hasDownload
//            anchors {
//                top: uploadSection.bottom
//                topMargin: 8
//            }
//        }

//        DownloadSectionHire {
//            id: downloadSectionHire
//            title: Texts.Main.DOWNLOAD_SECTION_TITLE
//            description: Texts.Main.DOWNLOAD_SECTION_HIRE_DESCRIPTION
//            hireDownloadUrl: Address.HIRE_DOWNLOAD_URL
//            visible: !hasDownload
//            anchors {
//                top: uploadSection.bottom
//                topMargin: 8
//            }
//        }

        DsButton {
            id: btnDetails
            text: 'Ver detalhes'
            anchors {
                right: content.right
                bottom: content.bottom
            }
            onClicked: Qt.openUrlExternally(webDetailLink);
        }
    }
}
