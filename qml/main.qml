import QtQuick 2.12
import QtQuick.Controls 2.12
import './helpers/factory.js' as Factory
import './helpers/timer.js' as Timer
import './constants/times.js' as Times
import './lib/google-analytics.js' as GA
import './services';

ApplicationWindow {
    id: app

    property var temp: ({});

    function navigateTo(screen) {
        const currentItem = stack.currentItem;
        stack.replace(currentItem, Factory.createPresenter(screen));
        currentItem.destroy();
    }

    visible: true
    width: 670
    height: 524
    minimumWidth: 670
    maximumWidth: 670
    minimumHeight: 524
    maximumHeight: 524
    title: 'Arquivei'
    onClosing: {
        app.hide();
    }

    Component.onCompleted: {
        GA.setClientId(clientService.getMacAddress());
        GA.startSession();
        Timer.setInterval(() => GA.trackEvent(GA.EventCategories.ACTIVITY, GA.EventActions.APP_RUNNING), Times.APP_ACTIVITY_GA_EVENT_INTERVAL, app);
    }

    Component.onDestruction: {
        GA.setClientId(clientService.getMacAddress());
        GA.endSession();
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

    ClientService {
        id: clientService
    }
}
