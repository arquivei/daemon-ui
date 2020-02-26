import QtQuick 2.12
import '../../helpers/timer.js' as Timer
import '../../constants/times.js' as Times
import '../..'
import '.'

Presenter {
    id: root

    property SplashModel model: SplashModel {}

    Component.onCompleted: {
        Timer.setTimeout(() => {
            if (!model.isAuthenticated()) {
                return app.navigateTo('Auth');
            }

            if (!model.isConfigured()) {
                return app.navigateTo('Config');
            }

            app.navigateTo('Main');
        }, Times.SPLASH_SCREEN_DELAY);
    }

    SplashView {
        id: view;
        anchors.fill: parent;
    }
}
