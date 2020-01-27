import QtQuick 2.0

Rectangle {
    property int type

    enum Types {
        Default,
        Bordered
    }

    id: root
    color: type === DsCard.Types.Bordered ? 'transparent' : '#F5F5F5'
    radius: 8
    border {
        width: type === DsCard.Types.Bordered ? 1 : 0
        color: '#D0D0D0'
    }

    height: childrenRect.height
}
