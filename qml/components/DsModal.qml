import QtQuick 2.12
import QtQuick.Controls 2.12
import '../constants/colors.js' as Colors
import '../helpers/factory.js' as Factory

Popup {
    property bool showSecondaryButton
    property bool showActions: true
    property string title
    property string text
    property string primaryActionLabel
    property string secondaryActionLabel
    property string titleColor: Colors.BRAND_TERTIARY_DEFAULT

    signal primaryAction()
    signal secondaryAction()

    id: root
    modal: true
    focus: true
    padding: 16
    closePolicy: Popup.NoAutoClose
    width: 418
    height: content.implicitHeight
    anchors.centerIn: parent

    background: Rectangle {
        id: box
        radius: 8
        border.width: 0
    }

    Overlay.modal: Rectangle {
        color: Colors.MODAL_OVERLAY
    }

    contentItem: Item {
        id: content
        implicitWidth: parent.width
        implicitHeight: childrenRect.height + 32

        DsText {
            id: titleText
            text: root.title
            color: root.titleColor
            font.weight: 'Bold'
            fontSize: 18
            lineHeight: 26
            wrapMode: Text.WordWrap

            width: parent.width
        }

        DsText {
            id: descriptionText
            text: root.text
            fontSize: 14
            lineHeight: 22
            color: Colors.GRAYSCALE_500
            wrapMode: Text.WordWrap

            width: parent.width
            anchors {
                left: parent.left
                top: titleText.bottom
                topMargin: 20
            }
        }

        Loader {
            id: actionsLoader
            width: parent.width
            sourceComponent: showActions ? Factory.createComponentFragment('DsModalActions') : null

            anchors {
                top: descriptionText.bottom
                topMargin: showActions ? 32 : 0
            }
        }
    }
}
