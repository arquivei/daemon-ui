import QtQuick 2.12
import '../constants/colors.js' as Colors
import '../constants/fonts.js' as Fonts

Text {
    id: root

    property bool linkDisabled: false
    property bool isLinkHovered: false

    property alias fontSize: root.font.pixelSize

    color: Colors.GRAYSCALE_500
    font.pixelSize: 12
    font.family: Fonts.PROXIMA_NOVA_SOFT
    lineHeightMode: Text.FixedHeight
    lineHeight: 18
    linkColor: linkDisabled ? Colors.GRAYSCALE_300 : Colors.BRAND_SECONDARY_DEFAULT
    verticalAlignment: Text.AlignVCenter

    onLinkDisabledChanged: {
        if (linkDisabled) {
            linkColor = Colors.GRAYSCALE_300
        } else {
            linkColor = Colors.BRAND_SECONDARY_DEFAULT
        }
    }

    onHoveredLinkChanged: {
      isLinkHovered = !isLinkHovered
    }

    onLinkHovered: {
        if (linkDisabled) {
            return;
        }

        if (link) {
            root.linkColor = Colors.BRAND_SECONDARY_DARK;
        } else {
            root.linkColor = Colors.BRAND_SECONDARY_DEFAULT;
        }
    }

    onLinkActivated: {
        Qt.openUrlExternally(link);
    }
}
