import QtQuick 2.12
import '../constants/colors.js' as Colors

DsText {
    property string href
    property string label
    property bool isHovered: false
    property bool isBlocked: false

    property alias fontSize: root.font.pixelSize

    signal click()

    function getText() {
        const link = href || '#';
        return '<a href="' + link + '">' + label + '</a>';
    }

    id: root
    textFormat: Text.StyledText
    linkColor: Colors.BRAND_SECONDARY_DEFAULT
    text: getText()
    fontSize: 14
    font.weight: "Bold"
    lineHeight: 22

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        width: parent.width
        height: parent.height
        onClicked: {
            if (!isBlocked) {
                href ? root.linkActivated(href) : root.click()
            }
        }
        hoverEnabled: !isBlocked
        onHoveredChanged: {
            isHovered = !isHovered;

            if (isHovered) {
                linkColor = Colors.BRAND_SECONDARY_DARK;
            } else {
                linkColor = Colors.BRAND_SECONDARY_DEFAULT;
            }
        }
    }
}
