function Timer() {
    return Qt.createQmlObject("import QtQuick 2.12; Timer {}", root);
}

function setTimeout(cb, delayTime) {
    const timer = new Timer();
    timer.interval = delayTime;
    timer.repeat = false;
    timer.triggered.connect(cb);
    timer.start();
}
