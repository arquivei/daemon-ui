import QtQuick 2.12
import QtQuick.Controls 2.12
import './helpers/factory.js' as Factory

ApplicationWindow {
    id: app
    visible: true
    width: 670
    height: 524
    minimumWidth: 670
    maximumWidth: 670
    minimumHeight: 524
    maximumHeight: 524
    title: 'Arquivei DocBox'

    function navigateTo(screen) {
        const currentItem = stack.currentItem;
        stack.replace(currentItem, Factory.createPresenter(screen));
        currentItem.destroy();
    }

    FontLoader {
        source: 'qrc:/fonts/pns-regular-webfont.otf'
    }

    FontLoader {
        source: 'qrc:/fonts/pns-medium-webfont.otf'
    }

    FontLoader {
        source: 'qrc:/fonts/pns-semibold-webfont.otf'
    }

    FontLoader {
        source: 'qrc:/fonts/pns-bold-webfont.otf'
    }

    StackView {
        id: stack
        initialItem: Factory.createPresenter('Splash')
        anchors.fill: parent
    }
}
