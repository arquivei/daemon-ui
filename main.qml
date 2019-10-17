import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import Qt.labs.platform 1.1

ApplicationWindow {
    id: window
    visible: true
    width: 320
    height: 240
    minimumWidth: 320
    minimumHeight: 240
    title: qsTr("Arquivei Daemon")

    property string uploadFolder

    FontLoader {
        id: fontLoader
        source: "fonts/RobotoMono-Regular.ttf"
    }

    StackView {
        id: stack
        initialItem: InstallView {}
        anchors.fill: parent
        anchors.margins: 24
        font.family: "Roboto Mono"
    }

    SystemTrayIcon {
        visible: true
        icon.source: "images/settings.svg"

        menu: Menu {
            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }
    }
}
