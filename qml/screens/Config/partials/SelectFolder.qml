import '../../../components'
import '../../../constants/texts.js' as Texts

DsButton {
    id: selectFolderBtn
    text: Texts.Config.SELECT_FOLDER_BUTTON_LABEL
    isBlocked: root.isBlocked

    onClicked: openDialog()
}
