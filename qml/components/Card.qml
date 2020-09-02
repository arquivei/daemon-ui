import QtQuick 2.12
import '../constants/colors.js' as Colors

Rectangle {
    id: root

    property int type

    enum Types {
        Default,
        Bordered
    }

    color: type === Card.Types.Bordered ? Colors.PURE_WHITE : Colors.GRAYSCALE_100
    height: 138
    width: parent.width
    radius: 8
    border {
        width: type === Card.Types.Bordered ? 1 : 0
        color: Colors.GRAYSCALE_300
    }
}
