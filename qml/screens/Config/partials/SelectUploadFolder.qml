import QtQuick 2.12
import '../../../components'

DsButton {
    id: selectFolderBtn
    text: 'Selecionar pasta'
    isBlocked: root.isBlocked

    onClicked: openDialog()
}
