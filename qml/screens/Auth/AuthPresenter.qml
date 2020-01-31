import QtQuick 2.12
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
            const nextScreen = model.isConfigured() ? 'main' : 'config';
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
