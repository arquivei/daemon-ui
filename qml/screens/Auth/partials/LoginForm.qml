import QtQuick 2.0
import '../../../components'

Item {
    property string emailValue
    property string passwordValue
    property string invalidEmailMsg
    property string invalidPasswordMsg
    property string forgotPasswordUrl

    signal validateEmail(string email)
    signal validatePassword(string password)
    signal submit(string email, string password)

    function clear() {
        emailValue = '';
        passwordValue = '';
        invalidEmailMsg = '';
        invalidPasswordMsg = '';
    }

    id: root

    height: childrenRect.height

    DsInput {
        id: inputEmail
        text: emailValue
        label: 'Usuário:'
        placeholder: 'Insira seu e-mail aqui'
        errorMsg: invalidEmailMsg

        width: parent.width

        Keys.onReleased: {
            emailValue = inputEmail.text;
            if (invalidEmailMsg) {
                validateEmail(emailValue);
            }
        }

        onBlur: validateEmail(value)
    }

    DsInput {
        id: inputPassword
        text: passwordValue
        label: 'Senha:'
        placeholder: 'No mínimo 06 caracteres'
        isPassword: true
        errorMsg: invalidPasswordMsg

        width: parent.width
        anchors.top: inputEmail.bottom
        anchors.topMargin: 16

        Keys.onReleased: {
            passwordValue = inputPassword.text;
            if (invalidPasswordMsg) {
                validatePassword(passwordValue);
            }
        }

        onBlur: validatePassword(value)
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

            anchors.right: parent.right

            onClicked: submit(emailValue, passwordValue)
        }
    }
}
