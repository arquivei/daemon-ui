import QtQuick 2.0

Item {
    id: root

    Image {
        id: spinImage
        source: "../images/syncing.svg"
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit

        RotationAnimation on rotation {
            from: 0
            to: -360
            duration: 1500
            loops: Animation.Infinite
        }
    }
}

