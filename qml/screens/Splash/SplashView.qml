import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../components'

Page {
    id: root

    Item {
        id: content

        anchors {
            fill: parent
        }

        Image {
            id: imageLogo
            source: "qrc:/images/sincroniza-notas-logo-full.svg"
            height: 60
            width: 240
            fillMode: Image.PreserveAspectFit

            anchors {
                horizontalCenter: content.horizontalCenter
                verticalCenter: content.verticalCenter
            }
        }
    }
}
