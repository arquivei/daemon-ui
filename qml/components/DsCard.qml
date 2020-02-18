import QtQuick 2.12
import '../constants/colors.js' as Colors

Rectangle {
    property int type

    enum Types {
        Default,
        Bordered
    }

    id: root
    color: type === DsCard.Types.Bordered ? Colors.PURE_WHITE : Colors.GRAYSCALE_100
    radius: 8
    border {
        width: type === DsCard.Types.Bordered ? 1 : 0
        color: Colors.GRAYSCALE_300
    }
}
