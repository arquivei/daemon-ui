import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

Page {
    id: mainView

    Text {
        id: viewTitle
        text: "DAEMON"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        font.family: "Roboto Mono"
        font.weight: "Bold"
        font.pixelSize: 14
    }

    ColumnLayout {
        width: parent.width
        anchors.bottom: parent.bottom

        RowLayout {
            spacing: 8

            Image {
                id: pcIcon
                width: 24
                height: 24
                fillMode: Image.PreserveAspectFit
                source: "images/pc.svg"
            }
            Text {
                id: connectionText
                text: qsTr("PC01 - Connected")
                font.family: "Roboto Mono"
                color: "#1CC689"
            }
        }

        MenuSeparator {
            Layout.fillWidth: true
        }

        RowLayout {
            spacing: 8

            Image {
                id: settingsIcon
                width: 24
                height: 24
                fillMode: Image.PreserveAspectFit
                source: "images/settings.svg"
            }
            Text {
                id: settingsText
                text: qsTr("Settings")
                font.family: "Roboto Mono"
                color: "#0085FF"
                font.underline: true
            }
            MouseArea {
                id: mouseAreaSettings
                x: 0
                y: 0
                width: parent.width
                height: parent.height
                hoverEnabled: true
                onClicked: {
                    stack.push("AuthView.qml")
                }
                cursorShape: Qt.PointingHandCursor
            }
        }

        MenuSeparator {
            Layout.fillWidth: true
        }

        Loader {
            source: window.uploadFolder ? "SelectedFolderText.qml" : "AddFolder.qml"
        }
    }
}
