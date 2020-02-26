import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../components'
import '../../helpers/factory.js' as Factory

Item {
    id: btnSection
    width: parent.width
    implicitHeight: primaryButton.height

    Loader {
        id: secondaryButtonLoader
        sourceComponent: showSecondaryButton ? Factory.createComponentFragment('DsModalSecondaryButton') : null

        anchors {
            left: parent.left
            top: parent.top
        }
    }

    DsButton {
        id: primaryButton
        text: root.primaryActionLabel
        anchors {
            right: parent.right
            top: parent.top
        }

        onClicked: primaryAction()
    }
}
