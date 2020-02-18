import QtQuick 2.12
import '..'

DsButton {
    id: secondaryButton
    type: DsButton.Types.Inline
    text: secondaryActionLabel

    onClicked: secondaryAction()
}
