import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../components'
import './partials'
import '../../helpers/factory.js' as Factory
import '../../constants/addresses.js' as Address

Page {
    id: root

    property string email;
    property string password;
    property string errorMsg;
    property bool isLoading: false;

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
            source: "qrc:/images/sincroniza-notas-logo-full.svg"
            height: 60
            width: 240
            fillMode: Image.PreserveAspectFit

            anchors {
                top: parent.top
                topMargin: 56
                horizontalCenter: parent.horizontalCenter
            }
        }

        Loader {
            id: alertLoader
            sourceComponent: errorMsg ? Factory.createPartialFragment('Auth', 'FormAlert') : Factory.createEmptyFragment()

            width: parent.width

            anchors {
                top: imageLogo.bottom
                topMargin: 54
            }
        }

        LicenseAgreementSection {
            id: licenseAgreement

            width: parent.width
            anchors {
                bottom: parent.bottom
                bottomMargin: 16
            }

            useTermsUrl: Address.USE_TERMS_URL
            privacyPolicyUrl: Address.PRIVACY_POLICY_URL
        }

        LoginForm {
            id: loginForm

            forgotPasswordUrl: Address.FORGOT_PASSWORD_URL
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
