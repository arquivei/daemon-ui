import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../components'
import './partials'
import '../../helpers/validator.js' as Validator

Page {
    id: root

    property string email;
    property string password;
    property string errorMsg;
    property bool isLoading: false;

    property Component alertComponent: Component {
        DsAlert {
            id: alert
            message: errorMsg
        }
    }

    property Component emptyComponent: Component {
        Item {}
    }

    signal login(string email, string password)

    function clearForm() {
        errorMsg = ''
        loginForm.clear();
    }

    function setLoginErrorMsg(msg) {
        errorMsg = msg;
    }

    function toggleLoading() {
        isLoading = !isLoading;
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

            anchors {
                top: parent.top
                topMargin: 64
                horizontalCenter: parent.horizontalCenter
            }
        }

        Loader {
            id: alertLoader
            sourceComponent: errorMsg ? alertComponent: emptyComponent

            width: parent.width

            anchors {
                top: imageLogo.bottom
                topMargin: 64
            }
        }

        LicenseAgreementSection {
            id: licenseAgreement

            width: parent.width
            anchors {
                bottom: parent.bottom
                bottomMargin: 16
            }

            useTermsUrl: 'https://app.arquivei.com.br'
            privacyPolicyUrl: 'https://app.arquivei.com.br'
        }

        LoginForm {
            id: loginForm

            forgotPasswordUrl: 'https://app.arquivei.com.br'
            isLoading: root.isLoading

            width: parent.width
            anchors {
                top: alertLoader.bottom
                topMargin: errorMsg ? 16 : 0
            }

            onResetErrors: {
                setLoginErrorMsg('');
            }

            onSubmit: {
                setLoginErrorMsg('');
                login(email, password);
            }
        }
    }
}
