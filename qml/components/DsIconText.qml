import QtQuick 2.12

Item {
    property alias icon: imageIcon.source
    property string text
    property int textMaxLength

    function getTrimmedText() {
        return text.length > textMaxLength ? `${text.substring(0, textMaxLength)}...` : text;
    }

    id: root
    height: childrenRect.height
    width: childrenRect.width

    Image {
        id: imageIcon
        fillMode: Image.PreserveAspectFit

        anchors {
            left: parent.left
        }
    }

    DsText {
        id: textLabel
        text: getTrimmedText()
        color: '#737373'
        fontSize: 14
        font.weight: 'Bold'
        lineHeight: 22
        anchors {
            left: imageIcon.right
            leftMargin: 8
            verticalCenter: imageIcon.verticalCenter
        }
    }
}
