import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import './delegates'
import './models'

ApplicationWindow {
    id: app
    visible: true
    width: 320
    height: 320
    minimumWidth: 320
    minimumHeight: 320
    title: 'Arquivei Daemon'

    property string uploadFolder
    property bool isAuthenticated: false

    FontLoader {
        id: fontLoader
        source: 'fonts/RobotoMono-Regular.ttf'
    }

    StackView {
        id: stack
        initialItem: AuthView {
            model: AuthModel {}
            delegate: AuthDelegate {}
        }
        anchors.fill: parent
        anchors.margins: 24
        font.family: 'Roboto Mono'
    }
}
