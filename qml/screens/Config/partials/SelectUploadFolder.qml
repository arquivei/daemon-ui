import '../../../components'

DsButton {
    id: selectFolderBtn
    text: 'Selecionar pasta'
    isBlocked: root.isBlocked

    onClicked: openDialog()
}
