import QtQuick 2.12
import '../constants/colors.js' as Colors
import '../helpers/factory.js' as Factory

Item {
    property string href
    property string label
    property bool isHovered: false
    property bool isBlocked: false
    property bool isLoading: false

    property alias fontSize: textLink.font.pixelSize
    property alias lineHeight: textLink.lineHeight

    signal click()

    function getText() {
        const link = href || '#';
        return '<a href="' + link + '">' + label + '</a>';
    }

    id: root
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
        linkColor: Colors.BRAND_SECONDARY_DEFAULT
        text: getText()
        fontSize: 14
        font.weight: "Bold"
        lineHeight: 22

        anchors {
            left: isLoading ? spinnerLoader.right : parent.left
            leftMargin: isLoading ? 8 : 0
        }

        MouseArea {
            cursorShape: isLoading || isBlocked ? Qt.ArrowCursor : Qt.PointingHandCursor
            width: parent.width
            height: parent.height
            onClicked: {
                if (!isBlocked && !isLoading) {
                    href ? textLink.linkActivated(href) : root.click()
                }
            }
            hoverEnabled: true
            onHoveredChanged: {
                if (!isLoading && !isBlocked) {
                    isHovered = !isHovered;
                }

                if (isHovered) {
                    textLink.linkColor = Colors.BRAND_SECONDARY_DARK;
                } else {
                    textLink.linkColor = Colors.BRAND_SECONDARY_DEFAULT;
                }
            }
        }
    }
}
