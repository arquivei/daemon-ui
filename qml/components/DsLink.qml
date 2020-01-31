import QtQuick 2.12
import QtQuick.Controls 2.12

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
    linkColor: '#3CA9E1'
    text: getText()
    font.pixelSize: 14
    font.family: "Proxima Nova Soft"
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
                linkColor = '#396B8D';
            } else {
                linkColor = '#3CA9E1';
            }
        }
    }
}
