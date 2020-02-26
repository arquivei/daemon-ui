import QtQuick 2.12
import '../constants/colors.js' as Colors

Rectangle {
    property string defaultLabel
    property string loadingLabel
    property string successLabel
    property string errorLabel
    property int status: SyncProgress.Status.Default

    enum Status {
        Default,
        Loading,
        Success,
        Error
    }

    property var colors: {
        0: Colors.GRAYSCALE_400,
        1: Colors.BRAND_PRIMARY_DEFAULT,
        2: Colors.FEEDBACK_SUCCESS_DEFAULT,
        3: Colors.FEEDBACK_ERROR_DEFAULT
    }

    property var labels: {
        0: defaultLabel,
        1: loadingLabel,
        2: successLabel,
        3: errorLabel
    }

    id: root
    color: colors[status]
    radius: 20
    implicitWidth: childrenRect.width + (status === SyncProgress.Status.Loading ? 16 : 19)
    height: 32

    Item {
        id: statusIcon
        implicitWidth: status === SyncProgress.Status.Loading ? syncIcon.width : successIcon.width
        implicitHeight: status === SyncProgress.Status.Loading ? syncIcon.height : successIcon.height

        Image {
            id: successIcon
            source: "qrc:/images/white-alert-success.svg"
            visible: root.status === SyncProgress.Status.Success
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: dangerIcon
            source: "qrc:/images/white-alert-danger.svg"
            visible: root.status === SyncProgress.Status.Default || root.status === SyncProgress.Status.Error
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: syncIcon
            source: "qrc:/images/white-alert-sync.svg"
            visible: root.status === SyncProgress.Status.Loading
            fillMode: Image.PreserveAspectFit

            RotationAnimation on rotation {
                from: 0
                to: 360
                duration: 1500
                loops: Animation.Infinite
            }
        }

        anchors {
            left: parent.left
            leftMargin: status === SyncProgress.Status.Loading ? 4 : 6
            verticalCenter: parent.verticalCenter
        }
    }

    DsText {
        id: chipText
        color: Colors.PURE_WHITE
        text: labels[status]
        fontSize: 14
        font.weight: 'Bold'
        lineHeight: 22

        anchors {
            left: statusIcon.right
            leftMargin: status === SyncProgress.Status.Loading ? 8 : 10
            verticalCenter: statusIcon.verticalCenter
        }
    }
}
