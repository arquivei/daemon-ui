import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import '../../components'
import './partials'
import '../../constants/colors.js' as Colors
import '../../constants/addresses.js' as Address

Page {
    property string userEmail
    property string computerName
    property string webDetailLink

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

    function showFolderPermissionModal() {
        permissionErrorModal.open();
    }

    id: root

    DsModal {
        id: permissionErrorModal
        title: 'Atenção! Erro de permissão'
        showSecondaryButton: true
        text: 'Não é possível fazer o upload dos arquivos a partir da pasta selecionada por falta de permissão. Dê permissão de leitura e/ou escrita à pasta ou escolha uma nova pasta.'
        secondaryActionLabel: 'Fechar'
        primaryActionLabel: 'Ir para Configurações'
        onPrimaryAction: {
            permissionErrorModal.close();
            goToConfig();
        }
        onSecondaryAction: {
            permissionErrorModal.close();
        }
    }

    DsModal {
        id: authenticationErrorModal
        title: 'Atenção! Erro de autenticação'
        text: `Sua sessão expirou ou o usuário logado não possui mais permissão no aplicativo. Entre novamente ou fale com a gente em ${Address.SUPPORT_EMAIL}`
        primaryActionLabel: 'Ir para Login'
        onPrimaryAction: {
            authenticationErrorModal.close();
            logout();
        }
    }

    DsModal {
        id: connectionErrorModal
        showActions: false
        title: 'Offline - Erro de conexão!'
        titleColor: Colors.FEEDBACK_ERROR_DEFAULT
        text: '<strong>Falha ao tentar conectar aos nossos servidores.</strong><br>Verifique sua conexão com a internet, firewall, configuração de proxy ou antivírus.<br><br>Tentaremos reconectar automaticamente a cada 60s...'
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

        Header {
            id: header
            userEmail: root.userEmail
            onLogout: {
                root.logout();
            }
            onGoToConfig: {
                root.goToConfig();
            }
            onAccessWebDetailsPage: {
                Qt.openUrlExternally(webDetailLink);
            }
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

            anchors {
                top: title.bottom
                topMargin: 16
            }
        }

        DownloadSection {
            id: downloadSection

            anchors {
                top: uploadSection.bottom
                topMargin: 8
            }
        }

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
