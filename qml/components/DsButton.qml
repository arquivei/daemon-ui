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

    function getButtonColor() {
        if (isHovered) {
            switch(type) {
            case DsButton.Types.Special:
                return '#44774F';
            default:
                return '#124066';
            }
        }

        switch(type) {
        case DsButton.Types.Special:
            return '#47C661';
        default:
            return '#2074BA';
        }
    }

    id: root
    horizontalPadding: 16
    verticalPadding: 5
    background: Rectangle {
        id: buttonBackground
        color: getButtonColor()
        radius: 4

        MouseArea {
            cursorShape: Qt.PointingHandCursor
            width: parent.width
            height: parent.height
            onClicked: { root.clicked() }
            hoverEnabled: true
            onHoveredChanged: {
                isHovered = !isHovered;
                buttonBackground.color = getButtonColor();
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
