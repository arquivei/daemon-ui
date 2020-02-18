import QtQuick 2.12
import '../constants/colors.js' as Colors

Rectangle {
    property alias text: chipText.text

    id: root
    color: Colors.BRAND_SECONDARY_DEFAULT
    radius: 12
    width: 50
    height: 16

    DsText {
        id: chipText
        color: Colors.PURE_WHITE
        fontSize: 10
        font.weight: 'Bold'
        lineHeight: 18

        anchors {
            verticalCenter: root.verticalCenter
            horizontalCenter: root.horizontalCenter
        }
    }
}
