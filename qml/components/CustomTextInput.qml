import QtQuick 2.0
import QtQuick.Controls 2.5

TextField {
    property string placeholder
    property bool isPassword

    id: root
    placeholderText: placeholder
    font.pixelSize: 12
    echoMode: isPassword ? TextInput.Password : TextInput.Normal
    background: Rectangle {
        implicitHeight: 36
        border.color: root.activeFocus ? '#000' : '#bebebe'
    }
}
