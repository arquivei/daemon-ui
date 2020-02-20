import QtQuick 2.12
import '../constants/colors.js' as Colors
import '../constants/fonts.js' as Fonts

Text {
    property alias fontSize: root.font.pixelSize

    id: root
    color: Colors.GRAYSCALE_500
    font.pixelSize: 12
    font.family: Fonts.PROXIMA_NOVA_SOFT
    lineHeightMode: Text.FixedHeight
    lineHeight: 18
    linkColor: Colors.BRAND_SECONDARY_DEFAULT
    verticalAlignment: Text.AlignVCenter
    onLinkHovered: {
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
