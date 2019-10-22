import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml.Models 2.12

Page {
    id: root

    signal back
    signal openSelectFolder
    signal confirmEditFolder
    signal selectFolder
    signal logout
    signal confirmLogout

    property ItemDelegate delegate
    property ObjectModel model

    onBack: {
        stack.pop();
    }

    onOpenSelectFolder: {
        delegate.selectUploadFolderDialog.open();
    }

    onConfirmEditFolder: {
        delegate.confirmEditFolderDialog.open();
    }

    onSelectFolder: {
        model.uploadFolder = delegate.selectUploadFolderDialog.fileUrl
        model.syncUploadFolder();
        stack.pop();
    }

    onConfirmLogout: {
        delegate.confirmLogoutDialog.open();
    }

    onLogout: {
        model.logout();
        stack.pop(null);
    }

    contentItem: delegate
}
