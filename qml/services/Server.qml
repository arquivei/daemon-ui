import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml.Models 2.12

Item {
    id: root

    function authenticate(email, password) {
        const response = QmlBridge.authenticate(email, password);
        return JSON.parse(response);
    }
}
