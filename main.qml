import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: app
    visible: true
    width: 320
    height: 320
    minimumWidth: 320
    minimumHeight: 320
    title: "Arquivei Daemon"

    property string uploadFolder

    FontLoader {
        id: fontLoader
        source: "fonts/RobotoMono-Regular.ttf"
    }

    StackView {
        id: stack
        initialItem: AuthScreen {}
        anchors.fill: parent
        anchors.margins: 24
        font.family: "Roboto Mono"
    }

//    SystemTrayIcon {
//        visible: true
//        icon.source: "images/settings.svg"

//        menu: Menu {
//            MenuItem {
//                text: qsTr("Quit")
//                onTriggered: Qt.quit()
//            }
//        }
//    }
}
