import QtQuick 2.12
import '../..'
import '.'
import '../../lib/google-analytics.js' as GA

Presenter {
    id: root

    property AuthModel model: AuthModel {}

    Component.onCompleted: {
        GA.setClientId(model.getMacAddress());
        GA.trackScreen(GA.ScreenNames.AUTH);
    }

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
            GA.trackEvent(GA.EventCategories.AUTHENTICATION, GA.EventActions.SUCCESS_LOGIN, model.getEmail());
            view.toggleLoading();
            view.clearForm();
            model.isConfigured() ? app.navigateTo('Main') : app.navigateTo('Config');
        }
        onLoginError: {
            GA.trackEvent(GA.EventCategories.AUTHENTICATION, GA.EventActions.ERROR_LOGIN, model.getEmail());
            view.toggleLoading();
            view.setLoginErrorMsg(msg);
        }
    }

    AuthView {
        id: view;
        anchors.fill: parent;
    }
}
