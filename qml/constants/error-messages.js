.import "texts.js" as Texts

const Config = {
    ValidateFolder: {
        NO_WRITE_PERMISSION: {
            title: Texts.Config.Modals.WritingPermissionError.TITLE,
            description: Texts.Config.Modals.WritingPermissionError.DESCRIPTION
        },
        NO_READ_PERMISSION: {
            title: Texts.Config.Modals.ReadingPermissionError.TITLE,
            description: Texts.Config.Modals.ReadingPermissionError.DESCRIPTION
        },
        UNKNOWN_SERVER_ERROR: {
            title: Texts.Config.Modals.SelectFolderUnknownError.TITLE,
            description: Texts.Config.Modals.SelectFolderUnknownError.DESCRIPTION
        }
    },
    SaveConfigs: {
        UNKNOWN_SERVER_ERROR: {
            title: Texts.Config.Modals.SaveConfigsInternalError.TITLE,
            description: Texts.Config.Modals.SaveConfigsInternalError.DESCRIPTION
        }
    }
};

const Main = {
    ValidateFolder: {
        NO_WRITE_PERMISSION: {
            title: Texts.Main.Modals.WritingPermissionError.TITLE,
            description: Texts.Main.Modals.WritingPermissionError.DESCRIPTION
        },
        NO_READ_PERMISSION: {
            title: Texts.Main.Modals.ReadingPermissionError.TITLE,
            description: Texts.Main.Modals.ReadingPermissionError.DESCRIPTION
        },
        UNKNOWN_SERVER_ERROR: {
            title: Texts.Main.Modals.UseFolderUnknownError.TITLE,
            description: Texts.Main.Modals.UseFolderUnknownError.DESCRIPTION
        }
    }
};
