import QtQuick 2.0
import '../../services'
import '../..'
import '.'

Presenter {
    id: root

    property AuthModel model: AuthModel {}

    Connections {
        target: view
        onLogin: {
            model.login(email, password);
        }
    }

    Connections {
        target: model
        onLoginSuccess: {
            const nextScreen = app.isConfigured() ? 'main' : 'config';
            view.clearForm();
            app.push(nextScreen);
        }
        onLoginError: {
            view.setLoginErrorMsg(msg);
        }
    }

    AuthView {
        id: view;
        anchors.fill: parent;
    }
}
