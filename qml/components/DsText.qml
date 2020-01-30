import QtQuick 2.12
import QtQuick.Controls 2.12

Text {
    property alias fontSize: root.font.pixelSize

    id: root
    color: '#737373'
    font.pixelSize: 12
    font.family: "Proxima Nova Soft"
    lineHeightMode: Text.FixedHeight
    lineHeight: 18
    verticalAlignment: Text.AlignVCenter
}
