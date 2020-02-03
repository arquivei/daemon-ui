import QtQuick 2.12
import QtQuick.Controls 2.12
import '../constants/colors.js' as Colors
import '../constants/fonts.js' as Fonts

Text {
    property string href
    property string label
    property bool isHovered: false

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
    font.pixelSize: 14
    font.family: Fonts.PROXIMA_NOVA_SOFT
    font.weight: "Bold"
    lineHeightMode: Text.FixedHeight
    lineHeight: 22
    verticalAlignment: Text.AlignVCenter
    onLinkActivated: Qt.openUrlExternally(link)

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        width: parent.width
        height: parent.height
        onClicked: href ? root.linkActivated(href) : root.click()
        hoverEnabled: true
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
