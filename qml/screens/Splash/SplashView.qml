import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../components'

Page {
    id: root

    Item {
        id: content

        anchors {
            fill: parent
            topMargin: 32
            rightMargin: 32
            bottomMargin: 32
            leftMargin: 32
        }

        Image {
            id: imageMain
            source: "qrc:/images/app-logo-placeholder.svg"

            fillMode: Image.PreserveAspectFit

            anchors {
                horizontalCenter: content.horizontalCenter
                verticalCenter: content.verticalCenter
            }
        }

        Item {
            id: infoSection
            height: childrenRect.height
            width: childrenRect.width

            anchors {
                bottom: content.bottom
                horizontalCenter: content.horizontalCenter
            }

            DsText {
                id: textDevelopedBy
                text: 'Um produto desenvolvido por:'

                anchors {
                    top: parent.top
                }
            }

            Image {
                id: imageLogo
                source: "qrc:/images/arquivei-main.svg"
                height: 20
                width: 100
                fillMode: Image.PreserveAspectFit

                anchors {
                    top: textDevelopedBy.bottom
                    topMargin: 8
                    horizontalCenter: textDevelopedBy.horizontalCenter
                }
            }
        }
    }
}
