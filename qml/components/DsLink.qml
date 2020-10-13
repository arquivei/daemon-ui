import QtQuick 2.12
import '../constants/colors.js' as Colors
import '../helpers/factory.js' as Factory

Item {
    id: root

    property string href
    property string label
    property bool isBlocked: false
    property bool isLoading: false
    property bool isDisabled: false

    property alias fontSize: textLink.font.pixelSize
    property alias lineHeight: textLink.lineHeight
    property alias isHovered: textLink.isLinkHovered

    signal click()

    function getText() {
        const link = href || '#';
        return '<a href="' + link + '">' + label + '</a>';
    }

    implicitHeight: childrenRect.height
    implicitWidth: childrenRect.width

    Loader {
        id: spinnerLoader

        sourceComponent: isLoading ? Factory.createComponentFragment('LinkSpinner') : null

        anchors {
            verticalCenter: textLink.verticalCenter
        }
    }

    DsText {
        id: textLink

        textFormat: Text.StyledText
        text: getText()
        fontSize: 14
        font.weight: "Bold"
        lineHeight: 22
        linkDisabled: isDisabled

        anchors {
            left: isLoading ? spinnerLoader.right : parent.left
            leftMargin: isLoading ? 8 : 0
        }

        MouseArea {
            id: mouseArea

            cursorShape: isLoading || isBlocked || isDisabled ? Qt.ArrowCursor : Qt.PointingHandCursor
            width: parent.width
            height: parent.height

            onClicked: {
                if (!isBlocked && !isLoading && !isDisabled) {
                    href ? textLink.linkActivated(href) : root.click()
                }
            }
        }
    }
}
