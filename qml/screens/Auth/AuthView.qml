import QtQuick 2.0
import QtQuick.Controls 2.5
import '../../components'
import './partials'
import '../../helpers/validator.js' as Validator

Page {
    id: root

    property string email;
    property string password;

    signal login(string email, string password)

    function clearForm() {
        loginForm.clear();
    }

    function validateFormEmail(email) {
        if (email && !Validator.isEmailValid(email)) {
            loginForm.invalidEmailMsg = 'O formato do e-mail é inválido.'
        } else {
            loginForm.invalidEmailMsg = ''
        }
    }

    function validateFormPassword(password) {
        if (password && !Validator.isPasswordValid(password)) {
            loginForm.invalidPasswordMsg = 'A senha deve conter no mínimo 6 caracteres'
        } else {
            loginForm.invalidPasswordMsg = ''
        }
    }

    Item {
        id: itemContent

        width: 300
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: imageLogo
            source: "qrc:/images/arquivei-main.svg"
            fillMode: Image.PreserveAspectFit

            anchors.top: parent.top
            anchors.margins: 48
            anchors.horizontalCenter: parent.horizontalCenter
        }

        LoginForm {
            id: loginForm

            forgotPasswordUrl: 'https://app.arquivei.com.br'

            width: parent.width
            anchors.top: imageLogo.bottom
            anchors.margins: 64

            onValidateEmail: validateFormEmail(email)
            onValidatePassword: validateFormPassword(password)
            onSubmit: login(email, password)
        }

        LicenseAgreementSection {
            id: licenseAgreement

            width: parent.width
            anchors.bottom: parent.bottom

            useTermsUrl: 'https://app.arquivei.com.br'
            privacyPolicyUrl: 'https://app.arquivei.com.br'
        }
    }
}
