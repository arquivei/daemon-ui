import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.13
import '../constants/colors.js' as Colors

Item {
    property list<Action> actions
    property alias menuText: headerText.text
    property Action firstAction

    id: root
    implicitWidth: childrenRect.width
    implicitHeight: headerIcon.height

    anchors {
        right: parent.right
    }

    DsText {
        id: headerText
        color: Colors.BRAND_TERTIARY_DEFAULT
        font.weight: 'Bold'
        fontSize: 14
        lineHeight: 22

        anchors {
            left: parent.left
            verticalCenter: headerIcon.verticalCenter
        }
    }

    Image {
        id: headerIcon
        fillMode: Image.PreserveAspectFit
        source: 'qrc:/images/material-arrow-down.svg'
        transform: Rotation {
            angle: menu.opened ? 180 : 0
            origin {
                x: headerIcon.width / 2
                y: headerIcon.height / 2
            }
        }

        anchors {
            left: headerText.right
            leftMargin: 4
        }
    }

    Menu {
        contentData: actions

        id: menu
        closePolicy: Popup.CloseOnEscape | Popup.NoAutoClose | Popup.CloseOnPressOutsideParent

        width: childrenRect.width + 24
        x: parent.width - menu.width
        y: headerIcon.height + 8

        background: Rectangle {
            id: menuBackgroundContainer
            implicitWidth: 200
            implicitHeight: 40

            Rectangle {
                id: menuBackground
                border.width: 1
                border.color: Colors.GRAYSCALE_300
                color: Colors.PURE_WHITE
                radius: 4
                anchors {
                    fill: menuBackgroundContainer
                }
            }

            DropShadow {
                anchors.fill: menuBackground
                horizontalOffset: 0
                verticalOffset: 8
                radius: 16
                samples: 25
                color: Colors.DROP_SHADOW
                source: menuBackground
            }
        }

        delegate: MenuItem {
            id: menuItem
            implicitWidth: 200
            implicitHeight: 40

            contentItem: DsText {
                text: menuItem.text
                color: menuItem.highlighted ? Colors.FEEDBACK_ERROR_DEFAULT : Colors.GRAYSCALE_500
                font.weight: menuItem.highlighted ? Font.Bold : Font.Normal
                fontSize: 14
                lineHeight: 22
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight

                anchors {
                    left: parent.left
                    leftMargin: 16
                }
            }

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: 'transparent'

                MouseArea {
                    cursorShape: Qt.PointingHandCursor

                    anchors {
                        fill: parent
                    }

                    onClicked: menuItem.action.trigger()
                }
            }

            MenuSeparator {
               verticalPadding: 0
               horizontalPadding: 0
               contentItem: Rectangle {
                   implicitWidth: 200
                   implicitHeight: 1
                   color: menuItem.action === firstAction ? "transparent" : Colors.GRAYSCALE_300
               }
           }
        }
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor

        anchors {
            fill: parent
        }

        onClicked: {
            !menu.opened ? menu.open() : menu.close();
        }
    }
}
