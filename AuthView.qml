import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

Page {
    id: authView

    Text {
        id: viewTitle
        text: "AUTHENTICATION"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        font.family: "Roboto Mono"
        font.weight: "Bold"
        font.pixelSize: 14
    }

    ColumnLayout {
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter

        TextField {
            id: emailTextField
            placeholderText: qsTr("E-mail")
            Layout.fillWidth: true
            font.pixelSize: 12
        }

        TextField {
            id: passwordTextField
            placeholderText: qsTr("Password")
            width: parent.width
            Layout.fillWidth: true
            echoMode: "Password"
            font.pixelSize: 12
        }
    }

    Button {
        id: startButton
        anchors.bottom: parent.bottom
        width: parent.width
        background: Rectangle {
            color: '#000'
            radius: 20
        }
        contentItem: Text {
            color: '#fff'
            text: 'LOGIN'
            font.family: "Roboto Mono"
            font.weight: "Bold"
            horizontalAlignment: Text.AlignHCenter
        }
        onClicked: stack.push("MainView.qml")
    }
}
