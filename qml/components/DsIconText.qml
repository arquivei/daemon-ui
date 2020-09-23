import QtQuick 2.12
import '../helpers/text-helper.js' as TextHelper
import '../constants/colors.js' as Colors

Item {
    id: root

    property string text
    property int textMaxLength

    property alias icon: imageIcon.source
    property alias font: textLabel.font

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

        text: TextHelper.truncate(root.text, textMaxLength)
        color: Colors.GRAYSCALE_500
        fontSize: 14
        font.weight: 'Bold'
        lineHeight: 21

        anchors {
            left: imageIcon.right
            leftMargin: 8
            verticalCenter: imageIcon.verticalCenter
        }
    }
}
