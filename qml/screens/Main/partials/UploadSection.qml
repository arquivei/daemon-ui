import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/server-codes.js' as Codes

DsCard {
    property string title
    property string description
    property string successWarningTitle
    property string successWarningDescription
    property string processingStatus
    property int totalSent: 0
    property int total: 0
    property bool hasDocumentError: false

    function getSyncProgressStatus(processingStatus) {
        switch (processingStatus) {
        case Codes.DocumentProcessingStatus.STATUS_FINISHED:
            return SyncProgress.Status.Success;
        case Codes.DocumentProcessingStatus.STATUS_PROCESSING:
            return SyncProgress.Status.Loading;
        case Codes.DocumentProcessingStatus.STATUS_ERROR_UNKNOWN:
        case Codes.DocumentProcessingStatus.STATUS_ERROR_CONNECTION:
            return SyncProgress.Status.Error;
        default:
            return SyncProgress.Status.Default;
        }
    }

    function showStatusInfo(processingStatus) {
        switch (processingStatus) {
        case Codes.DocumentProcessingStatus.STATUS_PROCESSING:
        case Codes.DocumentProcessingStatus.STATUS_ERROR_UNKNOWN:
        case Codes.DocumentProcessingStatus.STATUS_ERROR_CONNECTION:
            return true;
        default:
            return false;
        }
    }

    id: root
    width: parent.width
    height: 138

    DsText {
        id: titleText
        text: root.title
        fontSize: 18
        font.weight: 'Bold'
        lineHeight: 26
        color: Colors.BRAND_TERTIARY_DEFAULT

        anchors {
            top: parent.top
            topMargin: 16
            left: parent.left
            leftMargin: 16
        }
    }

    DsText {
        id: descriptionText
        text: root.description
        fontSize: 12
        lineHeight: 16
        color: Colors.GRAYSCALE_500

        anchors {
            top: titleText.bottom
            left: parent.left
            leftMargin: 16
        }
    }

    SyncProgress {
        id: progress
        defaultLabel: 'Arquivos XML e ZIP não encontrados'
        loadingLabel: 'Enviando arquivos'
        successLabel: 'Envio finalizado'
        errorLabel: 'Envio interrompido'
        status: getSyncProgressStatus(processingStatus)

        anchors {
            top: descriptionText.bottom
            topMargin: 24
            left: parent.left
            leftMargin: 12
        }
    }

    SendingStatusInfo {
        id: sendingStatusInfo
        show: showStatusInfo(root.processingStatus)
        totalFiles: root.total
        sentFiles: root.totalSent

        anchors {
            left: progress.right
            leftMargin: 16
            verticalCenter: progress.verticalCenter
        }
    }

    SendSuccessWarning {
        id: sendSuccessWarning
        show: processingStatus === Codes.DocumentProcessingStatus.STATUS_FINISHED && hasDocumentError
        title: root.successWarningTitle
        description: root.successWarningDescription

        anchors {
            left: progress.right
            leftMargin: 16
            verticalCenter: progress.verticalCenter
        }
    }
}
