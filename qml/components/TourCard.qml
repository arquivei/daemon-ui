import QtQuick 2.12
import '../constants/colors.js' as Colors
import '../helpers/factory.js' as Factory

Rectangle {
    property string title
    property string description
    property string chipInfo
    property string prevLabel
    property string nextLabel
    property bool showCloseAction
    property var customWidth

    signal prev()
    signal next()
    signal close()

    id: root
    color: Colors.PURE_WHITE
    radius: 8
    implicitHeight: childrenRect.height + 32
    width: customWidth || 239

    Item {
        id: content
        implicitHeight: childrenRect.height

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 16
        }

        DsChip {
            id: stepsChip
            text: root.chipInfo

            anchors {
                top: content.top
                left: content.left
            }
        }

        Loader {
            id: closeActionLoader
            sourceComponent: showCloseAction ? Factory.createComponentFragment('TourCardCloseAction') : null

            anchors {
                right: content.right
                verticalCenter: stepsChip.verticalCenter
            }
        }

        DsText {
            id: titleText
            text: root.title
            color: Colors.BRAND_TERTIARY_DEFAULT
            fontSize: 18
            font.weight: 'Bold'
            lineHeight: 26
            wrapMode: Text.WordWrap

            anchors {
                top: stepsChip.bottom
                topMargin: 16
                left: content.left
                right: content.right
            }
        }

        DsText {
            id: descriptionText
            text: root.description
            lineHeight: 16
            wrapMode: Text.WordWrap

            anchors {
                top: titleText.bottom
                topMargin: 8
                left: content.left
                right: content.right
            }
        }

        Loader {
            id: prevActionBtnLoader
            sourceComponent: prevLabel ? Factory.createComponentFragment('TourCardPrevAction') : null

            anchors {
                top: descriptionText.bottom
                topMargin: 16
                left: content.left
            }
        }

        DsButton {
            id: nextActionBtn
            text: root.nextLabel
            size: DsButton.Sizes.Small

            anchors {
                top: descriptionText.bottom
                topMargin: 16
                right: content.right
            }

            onClicked: {
                next();
            }
        }
    }
}
