import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

Page {
    id: installView

    Text {
        id: viewTitle
        text: "DAEMON - INSTALL"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        font.family: "Roboto Mono"
        font.weight: "Bold"
        font.pixelSize: 14
    }

    Item {
        anchors.top: viewTitle.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        RowLayout {
            id: row
            anchors.bottom: startButton.top
            anchors.bottomMargin: 14
            width: parent.width
            spacing: 2

            CheckBox {
                id: autoUpdateCheckBox
                padding: 0
                height: 16
                indicator.width: 16
                indicator.height: 16
            }

            Label {
                text: "Opt-in Auto-update"
                font.pixelSize: 12
                Layout.fillWidth: true
            }
        }

        Button {
            id: startButton
            anchors.bottom: parent.bottom
            width: parent.width
            background: Rectangle {
                color: '#000'
                radius: 20
            }
            contentItem: Text {
                color: '#fff'
                text: 'START'
                font.family: "Roboto Mono"
                font.weight: "Bold"
                horizontalAlignment: Text.AlignHCenter
            }
            onClicked: stack.push("AuthView.qml")
        }
    }
}
