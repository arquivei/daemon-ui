import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml.Models 2.12

Page {
    id: root

    signal submit
    signal loginSuccess
    signal loginError(string errorMsg)

    property ItemDelegate delegate
    property ObjectModel model

    onLoginSuccess: {
        const configViewString = 'import QtQuick 2.0; import "./delegates"; import "./models"; ConfigView { delegate: ConfigDelegate {} model: ConfigModel {} }';
        const mainViewString = 'import QtQuick 2.0; import "./delegates"; import "./models"; MainView { delegate: MainDelegate {} model: MainModel {} }';
        const mainViewObject = Qt.createQmlObject(mainViewString, root);
        const view = model.uploadFolder ? mainViewObject : [mainViewObject, Qt.createQmlObject(configViewString, root)];
        stack.push(view);

        delegate.state = 'initial';
        model.email = '';
        model.password = '';
    }

    onLoginError: {
        delegate.state = 'error';
        model.email = '';
        model.password = '';
        model.errorMsg = errorMsg;
    }

    onSubmit: {
        delegate.state = 'loading';
        model.authenticate(() => root.loginSuccess(), (errMsg) => root.loginError(errMsg));
    }

    contentItem: delegate
}
