import QtQuick 2.0

Item {
    id: root

    property string errorUrl
    property string successUrl

    width: parent.width
    height: row.height

    states: [
        State {
            name: "syncing"
            PropertyChanges { target: syncText; text: 'Sincronizando...' }
            PropertyChanges { target: syncingImg; visible: true }
            PropertyChanges { target: successImg; visible: false }
            PropertyChanges { target: errorImg; visible: false }
            PropertyChanges { target: detailsBtn; visible: false }
        },
        State {
            name: "success"
            PropertyChanges { target: syncText; text: 'Sincronizado' }
            PropertyChanges { target: syncingImg; visible: false }
            PropertyChanges { target: successImg; visible: true }
            PropertyChanges { target: errorImg; visible: false }
            PropertyChanges { target: detailsBtn; visible: true; onClicked: {
                    Qt.openUrlExternally(root.successUrl);
                }
            }
        },
        State {
            name: "error"
            PropertyChanges { target: syncText; text: 'Falhou' }
            PropertyChanges { target: syncingImg; visible: false }
            PropertyChanges { target: successImg; visible: false }
            PropertyChanges { target: errorImg; visible: true }
            PropertyChanges { target: detailsBtn; visible: true; onClicked: {
                    Qt.openUrlExternally(root.errorUrl)
                }
            }
        }
    ]

    Row {
        id: row
        spacing: 6

        Item {
            width: 36
            height: 36
            anchors.verticalCenter: parent.verticalCenter

            Image {
                id: syncingImg
                source: "qrc:/images/syncing.svg"
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectFit

                RotationAnimation on rotation {
                    from: 0
                    to: -360
                    duration: 1500
                    loops: Animation.Infinite
                }
            }

            Image {
                id: successImg
                source: "qrc:/images/success.png"
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: errorImg
                source: "qrc:/images/error.svg"
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectFit
            }
        }

        Text {
            id: syncText
            font.family: "Roboto Mono"
            font.weight: "Bold"
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    CustomButton {
        id: detailsBtn
        text: 'Detalhes'
        fontSize: 12
        radius: 6
        anchors.verticalCenter: row.verticalCenter
        anchors.right: parent.right
    }
}
