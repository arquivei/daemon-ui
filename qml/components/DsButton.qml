import QtQuick 2.0
import QtQuick.Controls 2.5

Button {
    property alias fontSize: buttonContent.font.pixelSize
    property int type: DsButton.Types.Default
    property bool isHovered: false

    enum Types {
        Default,
        Special
    }

    id: root
    horizontalPadding: 16
    verticalPadding: 5
    background: Rectangle {
        id: buttonBackground
        radius: 4
        color: {
            if (!root.enabled) {
                return '#D0D0D0';
            }

            if (isHovered && type === DsButton.Types.Special) {
                return '#44774f';
            }

            if (isHovered) {
                return '#124066';
            }

            if (type === DsButton.Types.Special) {
                return '#47C661';
            }

            return '#2074BA';
        }

        MouseArea {
            cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
            width: parent.width
            height: parent.height
            enabled: root.enabled
            hoverEnabled: true

            onClicked: root.clicked()
            onHoveredChanged: {
                isHovered = !isHovered;
            }
        }
    }

    contentItem: Text {
        id: buttonContent
        color: '#fff'
        text: root.text
        font.pixelSize: 14
        font.family: "Proxima Nova Soft"
        font.weight: "Bold"
        lineHeightMode: Text.FixedHeight
        lineHeight: 22
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
