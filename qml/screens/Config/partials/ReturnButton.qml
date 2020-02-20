import '../../../components';

DsButton {
    id: btnTour
    text: 'Voltar'
    type: DsButton.Types.Inline
    onClicked: {
        if (hasBeenEdited) {
            notSavedChangesAlertModal.open();
        } else {
            returnToMain();
        }
    }
}
