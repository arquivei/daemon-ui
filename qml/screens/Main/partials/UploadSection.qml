import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/server-codes.js' as Codes
import '../../../constants/texts.js' as Texts

Card {
    id: root

    property string title: Texts.General.UPLOAD_SECTION_TITLE
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

    DsText {
        id: titleText
        text: root.title
        fontSize: 20
        font.weight: 'Bold'
        lineHeight: 24
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
        lineHeight: 18
        color: Colors.GRAYSCALE_500

        anchors {
            top: titleText.bottom
            topMargin: 2
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
        status: getSyncProgressStatus(priv.uploadProcessingStatus)

        anchors {
            bottom: parent.bottom
            bottomMargin: 24
            left: parent.left
            leftMargin: 12
        }
    }

    SendingStatusInfo {
        id: sendingStatusInfo
        show: showStatusInfo(priv.uploadProcessingStatus)
        totalFiles: priv.uploadTotal
        sentFiles: priv.uploadTotalSent

        anchors {
            left: progress.right
            leftMargin: 16
            verticalCenter: progress.verticalCenter
        }
    }

    SendSuccessWarning {
        id: sendSuccessWarning
        show: priv.uploadProcessingStatus === Codes.DocumentProcessingStatus.STATUS_FINISHED && priv.uploadHasDocumentError
        title: root.successWarningTitle
        description: root.successWarningDescription

        anchors {
            left: progress.right
            leftMargin: 16
            verticalCenter: progress.verticalCenter
        }
    }
}
