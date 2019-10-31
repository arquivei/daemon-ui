import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml.Models 2.12

Page {
    id: root

    signal openWeb
    signal openConfig

    property ItemDelegate delegate
    property ObjectModel model

    StackView.onStatusChanged: {
        if (StackView.status === StackView.Activating) {
            delegate.state = 'syncing';
            model.syncFolder(() => delegate.state = 'success', () => delegate.state = 'error');
        }
    }

    onOpenWeb: {
        Qt.openUrlExternally('https://app.arquivei.com.br')
    }

    onOpenConfig: {
        const configViewString = 'import QtQuick 2.0; import "./delegates"; import "./models"; ConfigView { delegate: ConfigDelegate {} model: ConfigModel {} }';
        stack.push(Qt.createQmlObject(configViewString, root))
    }
    
    contentItem: delegate
}
