import QtQuick 2.12
import '../constants/z-axis.js' as Z

Item {
    property string title
    property string description
    property string chipInfo
    property string nextLabel
    property string prevLabel
    property bool showCloseAction: true
    property var ref
    property var position

    signal next()
    signal prev()
    signal close()

    function start() {
        visible = true
        ref.isBlocked = true
        ref.z = Z.ABOVE_OVERLAY
    }

    function stop() {
        visible = false
        ref.isBlocked = false
        ref.z = Z.DEFAULT
    }

    id: root
    implicitWidth: tourCard.width
    implicitHeight: tourCard.height
    visible: false
    z: Z.OVERLAY

    Component.onCompleted: {
        Object.keys(position).forEach(pos => {
            root.anchors[pos] = position[pos];
        });
    }

    DsOverlay {
        id: overlay
        type: DsOverlay.Types.Dark
    }

    TourCard {
        id: tourCard
        title: root.title
        description: root.description
        chipInfo: root.chipInfo
        prevLabel: root.prevLabel
        nextLabel: root.nextLabel
        showCloseAction: root.showCloseAction
        onPrev: {
            stop();
            root.prev();
        }
        onNext: {
            stop();
            root.next();
        }
        onClose: {
            stop();
            root.close();
        }
    }
}

