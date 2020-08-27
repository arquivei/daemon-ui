import QtQuick 2.12

Image {
    id: spinner

    property int size: DsButton.Sizes.Default
    enum Sizes {
        Default,
        Small
    }

    QtObject {
        id: priv
        property var heightAndWidth: ({
            [Spinner.Sizes.Default]: 16,
            [Spinner.Sizes.Small]: 14,
        })
    }

    fillMode: Image.PreserveAspectFit
    width: priv.heightAndWidth[size]
    height: priv.heightAndWidth[size]

    RotationAnimation on rotation {
        from: 0
        to: 360
        duration: 1500
        loops: Animation.Infinite
    }
}
