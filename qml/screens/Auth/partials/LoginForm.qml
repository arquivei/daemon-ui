import QtQuick 2.12
import '../../../components'
import '../../../helpers/validator.js' as Validator

Item {
    property string emailValue: ''
    property string passwordValue: ''
    property string invalidEmailMsg
    property string forgotPasswordUrl
    property bool isLoading: false

    signal resetErrors()
    signal submit(string email, string password)

    function validateEmail(email) {
        if (Validator.isEmailValid(email)) {
            invalidEmailMsg = '';
        } else {
            invalidEmailMsg = 'O formato do e-mail é inválido.'
        }
    }

    function clear() {
        emailValue = '';
        passwordValue = '';
        invalidEmailMsg = '';
    }

    function triggerLoginAction() {
        resetErrors();
        validateEmail(emailValue);

        if (!invalidEmailMsg) {
            submit(emailValue, passwordValue)
        }
    }

    id: root

    height: childrenRect.height

    Keys.onReleased: {
        if (!btnLogin.enabled) {
            return;
        }

        if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
            triggerLoginAction();
        }
    }

    DsInput {
        id: inputEmail
        text: emailValue
        label: 'Usuário:'
        placeholder: 'Insira seu e-mail aqui'
        errorMsg: invalidEmailMsg
        enabled: !isLoading

        width: parent.width

        Keys.onReleased: {
            emailValue = inputEmail.text;
            if (invalidEmailMsg) {
                invalidEmailMsg = ''
            }
        }
    }

    DsInput {
        id: inputPassword
        text: passwordValue
        label: 'Senha:'
        placeholder: 'No mínimo 06 caracteres'
        isPassword: true
        enabled: !isLoading

        width: parent.width
        anchors.top: inputEmail.bottom
        anchors.topMargin: 16

        Keys.onReleased: {
            passwordValue = inputPassword.text;
        }
    }

    Item {
        id: itemFormActions
        width: parent.width
        height: childrenRect.height

        anchors.top: inputPassword.bottom
        anchors.topMargin: 16

        DsLink {
            id: linkForgotPassword
            href: forgotPasswordUrl
            label: 'Esqueceu a senha?'

            anchors.verticalCenter: btnLogin.verticalCenter
        }

        DsButton {
            id: btnLogin
            text: 'Entrar'
            type: DsButton.Types.Special
            loadingText: 'Entrando...'
            isLoading: root.isLoading
            anchors.right: parent.right
            enabled: {
                return emailValue.length >= 1 && Validator.isPasswordValid(passwordValue);
            }

            onClicked: triggerLoginAction()
        }
    }
}
