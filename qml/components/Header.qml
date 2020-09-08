import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    property string userEmail;
    property list<Action> actions;
    property Action current;
    property Action alertAction;

    id: root
    width: parent.width
    height: childrenRect.height

    Image {
        id: imageLogo
        source: "qrc:/images/sincroniza-notas-logo.svg"
        height: 24
        width: 160
        fillMode: Image.PreserveAspectFit

        anchors {
            top: parent.top
            left: parent.left
        }
    }

    DsDropDownMenu {
        id: menu
        menuText: root.userEmail
        current: root.current
        alertAction: root.alertAction
        actions: root.actions

        anchors {
            top: parent.top
            right: parent.right
        }
    }
}
