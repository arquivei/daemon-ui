import QtQuick 2.12
import '../..'
import '.'

Presenter {
    id: root

    property AuthModel model: AuthModel {}

    Connections {
        target: view
        onLogin: {
            view.toggleLoading()
            model.login(email, password);
        }
    }

    Connections {
        target: model
        onLoginSuccess: {
            view.toggleLoading();
            view.clearForm();
            model.isConfigured() ? app.navigateTo('Main') : app.navigateTo('Config');
        }
        onLoginError: {
            view.toggleLoading();
            view.setLoginErrorMsg(msg);
        }
    }

    AuthView {
        id: view;
        anchors.fill: parent;
    }
}
