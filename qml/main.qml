import QtQuick 2.12
import QtQuick.Controls 2.12
import './delegates'
import './models'
import './screens/Auth'
import './screens/Config'
import './services'

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
    property ConfigPresenter configPresenter: ConfigPresenter {}

    property string uploadFolder
    property bool isAuthenticated: false

    function toLogin() {
        stack.pop(null);
    }

    function push(screen) {
        switch(screen) {
        case 'main':
            stack.push(mainView);
            break;
        case 'config':
            stack.push(configPresenter);
            break;
        default:
        }
    }

    Component.onCompleted: {
        if (authService.isAuthenticated()) {
            const nextScreen = configService.isConfigured() ? 'main' : 'config';
            push(nextScreen);
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
    }

    AuthService {
        id: authService
    }

    ConfigService {
        id: configService
    }
}
