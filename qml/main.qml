import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import './delegates'
import './models'

ApplicationWindow {
    id: app
    visible: true
    width: 400
    height: 400
    minimumWidth: 400
    minimumHeight: 400
    title: 'Arquivei Daemon'
    
    property string uploadFolder
    property bool isAuthenticated: false

    FontLoader {
        id: fontLoader
        source: 'qrc:/fonts/RobotoMono-Regular.ttf'
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
