import QtQuick 2.12
import QtQuick.Controls 2.5
import './delegates'
import './models'
import './screens/Auth'

ApplicationWindow {
    id: app
    visible: true
    width: 670
    height: 524
    minimumWidth: 670
    maximumWidth: 670
    minimumHeight: 524
    maximumHeight: 524
    title: 'Arquivei Daemon'

    property MainView mainView: MainView {
        delegate: MainDelegate {}
        model: MainModel {}
    }
    property ConfigView configView: ConfigView {
        delegate: ConfigDelegate {}
        model: ConfigModel {}
    }

    property string uploadFolder
    property bool isAuthenticated: false

    function isConfigured() {
        return uploadFolder ? true : false;
    }

    function push(screen) {
        switch(screen) {
        case 'main':
            stack.push(mainView);
            break;
        case 'config':
            stack.push(configView);
            break;
        default:
        }
    }

    Component.onCompleted: {
       isAuthenticated = QmlBridge.isAuthenticated;
        if (isAuthenticated) {
            stack.push(mainView);
        }
    }

    FontLoader {
        source: 'qrc:/fonts/pns-regular-webfont.otf'
    }

    FontLoader {
        source: 'qrc:/fonts/pns-medium-webfont.otf'
    }

    FontLoader {
        source: 'qrc:/fonts/pns-semibold-webfont.otf'
    }

    FontLoader {
        source: 'qrc:/fonts/pns-bold-webfont.otf'
    }

    StackView {
        id: stack
        initialItem: AuthPresenter {}
        anchors.fill: parent
        font.family: 'Roboto Mono'
        anchors.margins: 16
    }
}
