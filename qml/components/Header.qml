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
        current: root.current
        alertAction: root.alertAction
        actions: root.actions

        anchors {
            right: parent.right
        }
    }
}
