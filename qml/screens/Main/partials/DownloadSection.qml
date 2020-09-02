import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/server-codes.js' as Codes
import '../../../constants/texts.js' as Texts

Card {
    id: root

    property string title: Texts.General.DOWNLOAD_SECTION_TITLE
    property string description: Texts.Main.DOWNLOAD_SECTION_DESCRIPTION

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
        defaultLabel: Texts.Main.Download.SyncStatus.DEFAULT
        loadingLabel: Texts.Main.Download.SyncStatus.LOADING
        successLabel: Texts.Main.Download.SyncStatus.SUCCESS
        errorLabel: Texts.Main.Download.SyncStatus.ERROR
        status: getSyncProgressStatus(priv.downloadProcessingStatus)

        anchors {
            bottom: parent.bottom
            bottomMargin: 24
            left: parent.left
            leftMargin: 12
        }
    }

    DownloadStatusInfo {
        id: sendingStatusInfo
        show: showStatusInfo(priv.downloadProcessingStatus)
        totalDownloaded: priv.downloadTotal

        anchors {
            left: progress.right
            leftMargin: 16
            verticalCenter: progress.verticalCenter
        }
    }
}
