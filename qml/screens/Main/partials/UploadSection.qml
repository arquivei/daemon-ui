import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/server-codes.js' as Codes
import '../../../constants/texts.js' as Texts

DsCard {
    property string title: Texts.Main.UPLOAD_SECTION_TITLE
    property string description: Texts.Main.UPLOAD_SECTION_DESCRIPTION
    property string successWarningTitle: Texts.Main.SUCCESS_SENDING_WARNING_TITLE
    property string successWarningDescription: Texts.Main.SUCCESS_SENDING_WARNING_DESCRIPTION

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
        defaultLabel: Texts.Main.Upload.SyncStatus.DEFAULT
        loadingLabel: Texts.Main.Upload.SyncStatus.LOADING
        successLabel: Texts.Main.Upload.SyncStatus.SUCCESS
        errorLabel: Texts.Main.Upload.SyncStatus.ERROR
        status: getSyncProgressStatus(uploadProcessingStatus)

        anchors {
            top: descriptionText.bottom
            topMargin: 24
            left: parent.left
            leftMargin: 12
        }
    }

    SendingStatusInfo {
        id: sendingStatusInfo
        show: showStatusInfo(uploadProcessingStatus)
        totalFiles: uploadTotal
        sentFiles: uploadTotalSent

        anchors {
            left: progress.right
            leftMargin: 16
            verticalCenter: progress.verticalCenter
        }
    }

    SendSuccessWarning {
        id: sendSuccessWarning
        show: uploadProcessingStatus === Codes.DocumentProcessingStatus.STATUS_FINISHED && uploadHasDocumentError
        title: root.successWarningTitle
        description: root.successWarningDescription

        anchors {
            left: progress.right
            leftMargin: 16
            verticalCenter: progress.verticalCenter
        }
    }
}
