import QtQuick 2.12
import '../../../components'
import '../../../helpers/validator.js' as Validator
import '../../../constants/texts.js' as Texts

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
            invalidEmailMsg = Texts.Auth.INVALID_EMAIL_FORMAT
        }
    }

    function clear() {
        emailValue = '';
        passwordValue = '';
        invalidEmailMsg = '';
    }

    function triggerLoginAction() {
        resetErrors();
        emailValue = emailValue.trim();
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
        placeholder: Texts.Auth.USER_INPUT_PLACEHOLDER
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
        placeholder: Texts.Auth.PASSWORD_INPUT_PLACEHOLDER
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
