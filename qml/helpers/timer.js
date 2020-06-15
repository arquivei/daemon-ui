function Timer(parent) {
    return Qt.createQmlObject("import QtQuick 2.12; Timer {}", parent || root);
}

function setTimeout(cb, delayTime, parent) {
    const timer = new Timer(parent);
    timer.interval = delayTime;
    timer.repeat = false;
    timer.triggered.connect(cb);
    timer.start();
}

function setInterval(cb, intervalTime, parent) {
    const timer = new Timer(parent);
    timer.interval = intervalTime;
    timer.repeat = true;
    timer.triggered.connect(cb);
    timer.start();
}
