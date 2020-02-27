.import "texts.js" as Texts

const ValidateFolder = {
    NO_WRITE_PERMISSION: {
        title: Texts.General.Modals.FolderPermissionAlert.TITLE,
        description: Texts.General.Modals.FolderPermissionAlert.DESCRIPTION
    },
    NO_READ_PERMISSION: {
        title: Texts.General.Modals.FolderPermissionAlert.TITLE,
        description: Texts.General.Modals.FolderPermissionAlert.DESCRIPTION
    },
    UNKNOWN_SERVER_ERROR: {
        title: Texts.General.Modals.ValidateFolderInternalError.TITLE,
        description: Texts.General.Modals.ValidateFolderInternalError.DESCRIPTION
    }
};

const SaveConfigs = {
    UNKNOWN_SERVER_ERROR: {
        title: Texts.Config.Modals.SaveConfigsInternalError.TITLE,
        description: Texts.Config.Modals.SaveConfigsInternalError.DESCRIPTION
    }
};
