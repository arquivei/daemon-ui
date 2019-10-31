import QtQuick 2.0

Row {
    id: root

    property alias label: labelText.text
    property string path
    property string placeholder

    spacing: 4
    width: parent.width

    Text {
        id: labelText
        font.family: "Roboto Mono"
        font.weight: "Bold"
        font.pixelSize: 13
    }

    Text {
        text: path ? path : placeholder
        font.family: "Roboto Mono"
        font.pixelSize: 13
        elide: Text.ElideLeft
        width: root.width - labelText.width
    }
}
