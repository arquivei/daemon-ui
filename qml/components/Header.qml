import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    property string userEmail;

    signal logout()
    signal tourStart()
    signal goToConfig()
    signal accessWebDetailsPage()

    id: root
    width: parent.width
    height: childrenRect.height

    Image {
        id: imageLogo
        source: "qrc:/images/arquivei-icon.svg"
        fillMode: Image.PreserveAspectFit

        anchors {
            top: menu.top
            topMargin: 8
            left: parent.left
        }
    }

    DsDropDownMenu {
        id: menu
        menuText: root.userEmail
        firstAction: firstAction

        actions: [
            Action {
                id: firstAction
                text: 'Configurações'
                onTriggered: goToConfig()
            },
            Action {
                text: 'Acessar a Plataforma'
                onTriggered: accessWebDetailsPage()
            },
            Action {
                text: 'Iniciar Tour'
                onTriggered: tourStart()
            },
            Action {
                text: 'Sair'
                onTriggered: root.logout()
            }
        ]

        anchors {
            right: parent.right
        }
    }
}
