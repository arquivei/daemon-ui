import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    property alias fontSize: buttonContent.font.pixelSize
    property int type: DsButton.Types.Default
    property bool isHovered: false

    enum Types {
        Default,
        Special,
        Inline
    }

    function getTextColor() {
        if (type === DsButton.Types.Inline && enabled) {
            return isHovered ? '#737373' : '#B3B3B3';
        }

        return '#FFF';
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

            if (type === DsButton.Types.Inline) {
                return 'transparent';
            }

            if (type === DsButton.Types.Special) {
                return isHovered ? '#44774f' : '#47C661'
            }

            return isHovered ? '#124066' : '#2074BA';
        }

        border {
            width: type === DsButton.Types.Inline ? 1 : 0
            color: isHovered ? '#737373' : '#B3B3B3'
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
        color: getTextColor()
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
