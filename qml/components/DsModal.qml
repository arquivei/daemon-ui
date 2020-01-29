import QtQuick 2.0
import QtQuick.Controls 2.5

Popup {
    property bool showSecondaryButton
    property string secondaryActionLabel
    property alias title: titleText.text
    property alias text: descriptionText.text
    property alias primaryActionLabel: primaryButton.text

    property Component secondaryButton: Component {
        DsButton {
            id: secondaryButton
            type: DsButton.Types.Inline
            text: secondaryActionLabel

            onClicked: secondaryAction()
        }
    }

    property Component noSecondaryButton: Component {
        Item {}
    }

    signal primaryAction()
    signal secondaryAction()

    id: root
    modal: true
    focus: true
    padding: 16
    closePolicy: Popup.CloseOnEscape

    width: 418
    height: content.implicitHeight
    anchors.centerIn: parent

    background: Rectangle {
        id: box
        radius: 8
        border.width: 0
    }

    Overlay.modal: Rectangle {
        color: "#aa000000"
    }

    contentItem: Item {
        id: content
        implicitWidth: parent.width
        implicitHeight: childrenRect.height + 32

        DsText {
            id: titleText
            color: '#1D416E'
            font.weight: 'Bold'
            fontSize: 18
            lineHeight: 26
            wrapMode: Text.WordWrap

            width: parent.width
        }

        DsText {
            id: descriptionText
            fontSize: 14
            lineHeight: 22
            color: '#1D416E'
            wrapMode: Text.WordWrap

            width: parent.width
            anchors {
                left: parent.left
                top: titleText.bottom
                topMargin: 20
            }
        }

        Loader {
            id: secondaryButtonLoader
            sourceComponent: showSecondaryButton ? secondaryButton: noSecondaryButton

            anchors {
                left: parent.left
                top: descriptionText.bottom
                topMargin: 32
            }
        }

        DsButton {
            id: primaryButton

            anchors {
                right: parent.right
                top: descriptionText.bottom
                topMargin: 32
            }

            onClicked: primaryAction()
        }
    }
}
