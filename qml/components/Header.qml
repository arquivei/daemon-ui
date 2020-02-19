import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    signal logout()
    signal tourStart()

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
        menuText: 'user@email.com.br'
        firstAction: firstAction

        actions: [
            Action {
                id: firstAction
                text: 'Configurações'
                onTriggered: console.log('Abrir Configurações')
            },
            Action {
                text: 'Acessar a Plataforma'
                onTriggered: console.log('Acessar a Plataforma')
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
