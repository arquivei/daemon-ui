import QtQuick 2.12
import '..'

ImageButton {
    id: closeBtn
    source: 'qrc:/images/material-close.svg'

    onClicked: close();
}
