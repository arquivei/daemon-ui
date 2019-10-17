import QtQuick 2.0
import QtQuick.Layouts 1.13

RowLayout {
    spacing: 8

    Image {
        id: addFolderIcon
        width: 24
        height: 24
        fillMode: Image.PreserveAspectFit
        source: "images/ellipse.svg"
    }
    Text {
        id: uploadFolderText
        text: qsTr("Select Upload Folder")
        font.family: "Roboto Mono"
        color: "#0085FF"
        font.underline: true
    }
    MouseArea {
        id: mouseAreaAddFolder
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        hoverEnabled: true
        onClicked: {
            stack.push("SelectFolderView.qml")
        }
        cursorShape: Qt.PointingHandCursor
    }
}
