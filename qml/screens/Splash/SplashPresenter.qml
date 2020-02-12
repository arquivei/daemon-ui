import QtQuick 2.12
import '../../helpers/timer.js' as Timer
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
        }, 1500);
    }

    SplashView {
        id: view;
        anchors.fill: parent;
    }
}
