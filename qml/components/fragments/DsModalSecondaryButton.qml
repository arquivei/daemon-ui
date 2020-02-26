import '..'

DsButton {
    id: secondaryButton
    type: DsButton.Types.Inline
    text: secondaryActionLabel

    onClicked: secondaryAction()
}
