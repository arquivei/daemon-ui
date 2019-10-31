import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml.Models 2.12
import '../components'

ItemDelegate {
    id: root

    property ObjectModel model
    property Item view

    states: [
        State {
            name: 'initial'
            PropertyChanges { target: loginBtn; visible: true }
            PropertyChanges { target: spinLoader; visible: false }
        },
        State {
            name: 'loading'
            PropertyChanges { target: loginBtn; visible: false }
            PropertyChanges { target: spinLoader; visible: true }
        },
        State {
            name: 'error'
            PropertyChanges { target: feedbackText; visible: true; }
            PropertyChanges { target: loginBtn; visible: true }
            PropertyChanges { target: spinLoader; visible: false }
        }
    ]

    Component.onCompleted: {
        model = parent.model
        view = parent
        root.state = 'initial'
    }

    Title {
        id: title
        text: 'AUTHENTICATION'

        width: parent.width
        anchors.top: parent.top
    }

    Column {
        id: inputsColumn

        width: parent.width
        spacing: 8
        anchors.centerIn: parent

        CustomTextInput {
            id: emailInput
            placeholder: 'E-mail'
            text: model.email

            width: parent.width

            Keys.onReleased: {
                model.email = emailInput.text
            }
        }
        CustomTextInput {
            id: passwordInput
            placeholder: 'Password'
            text: model.password
            isPassword: true

            width: parent.width

            Keys.onReleased: {
                model.password = passwordInput.text
            }
        }
    }

    Text {
        id: feedbackText
        text: model.errorMsg
        visible: false
        font.family: 'Roboto Mono'
        font.pixelSize: 12
        color: '#ff002e'

        width: parent.width
        anchors.top: inputsColumn.bottom
        anchors.topMargin: 4
        horizontalAlignment: Text.AlignLeft
    }

    Column {
        id: actionsItem

        width: parent.width
        anchors.bottom: parent.bottom

        CustomButton {
            id: loginBtn
            text: 'LOGIN'

            width: parent.width

            onClicked: view.submit()
        }

        SpinLoader {
            id: spinLoader
            visible: false

            height: loginBtn.height
            width: parent.width
        }
    }
}
