import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import './components'

Page {
    id: root

    states: [
        State {
            name: "initial"
            PropertyChanges { target: loginBtn; visible: true }
            PropertyChanges { target: spinLoader; visible: false }
        },
        State {
            name: "loading"
            PropertyChanges { target: loginBtn; visible: false }
            PropertyChanges { target: spinLoader; visible: true }
        },
        State {
            name: "error"
            PropertyChanges { target: feedbackText; visible: true; text: "Authentication Failed" }
            PropertyChanges { target: loginBtn; visible: true }
            PropertyChanges { target: spinLoader; visible: false }
        }
    ]

    signal loginSuccess
    signal loginError

    Component.onCompleted: {
        root.state = "initial"
    }

    onLoginSuccess: {
        var screen = app.uploadFolder ? "MainScreen.qml" : ["MainScreen.qml", "ConfigScreen.qml"]
        stack.push(screen)
        root.state = 'initial'
        emailInput.text = ''
        passwordInput.text = ''
    }

    onLoginError: {
        root.state = "error"
        emailInput.text = ''
        passwordInput.text = ''
    }

    Title {
        id: title
        text: "AUTHENTICATION"

        width: parent.width
        anchors.top: parent.top
    }

    Column {
        id: inputsColumn

        spacing: 8
        width: parent.width
        anchors.centerIn: parent

        CustomTextInput {
            id: emailInput
            placeholder: 'E-mail'

            width: parent.width
        }
        CustomTextInput {
            id: passwordInput
            placeholder: 'Password'
            isPassword: true

            width: parent.width
        }
    }

    Text {
        id: feedbackText
        visible: false
        width: parent.width
        anchors.top: inputsColumn.bottom
        anchors.topMargin: 4
        horizontalAlignment: Text.AlignLeft
        font.family: "Roboto Mono"
        font.pixelSize: 12
        color: '#ff002e'
    }

    Column {
        id: actionsItem

        width: parent.width
        anchors.bottom: parent.bottom

        CustomButton {
            id: loginBtn
            text: 'LOGIN'

            width: parent.width

            onClicked: {
                root.state = "loading"
                simulateAsyncCall(
                            function () {
                                root.loginSuccess()
                            }, function () {
                                root.loginError()
                            }, 1000)
            }
        }

        SpinLoader {
            id: spinLoader
            visible: false

            height: loginBtn.height
            width: parent.width
        }
    }

    function simulateAsyncCall(successCB, errorCB, delay) {
        function Timer() {
            return Qt.createQmlObject("import QtQuick 2.0; Timer {}", root);
        }

        var callback = emailInput.text.length && passwordInput.text.length ? successCB : errorCB;

        var timer = new Timer();
        timer.interval = delay;
        timer.repeat = false;
        timer.triggered.connect(callback);
        timer.start();
    }
}
