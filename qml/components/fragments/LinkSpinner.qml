import QtQuick 2.12

Image {
    id: spinner
    source: "qrc:/images/link-loader.svg"
    fillMode: Image.PreserveAspectFit

    RotationAnimation on rotation {
        from: 0
        to: 360
        duration: 1500
        loops: Animation.Infinite
    }
}
