import QtQuick 2.12
import '../../../components'
import '../../../constants/colors.js' as Colors

Item {
    property string title
    property string description
    property bool show

    id: root
    visible: show
    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height

    DsText {
        id: firstRow
        text: root.title
        color: Colors.EXTRA_ORANGE_DEFAULT
        lineHeight: 16
    }

    DsText {
        text: root.description
        lineHeight: 16

        anchors {
            left: firstRow.left
            top: firstRow.bottom
        }
    }
}
