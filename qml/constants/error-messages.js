.import "texts.js" as Texts

const General = {
    CheckDownloadPermission: {
        UNKNOWN_SERVER_ERROR: {
            title: Texts.General.Modals.CheckDownloadPermissionError.TITLE,
            description: Texts.General.Modals.CheckDownloadPermissionError.DESCRIPTION,
        }
    },
    ValidateFolder: {
        NO_WRITE_PERMISSION: {
            title: Texts.General.Modals.WritingPermissionError.TITLE,
            description: Texts.General.Modals.WritingPermissionError.DESCRIPTION
        },
        NO_READ_PERMISSION: {
            title: Texts.General.Modals.ReadingPermissionError.TITLE,
            description: Texts.General.Modals.ReadingPermissionError.DESCRIPTION
        },
        UNKNOWN_SERVER_ERROR: {
            title: Texts.General.Modals.SelectFolderUnknownError.TITLE,
            description: Texts.General.Modals.SelectFolderUnknownError.DESCRIPTION
        },
        NO_VALID_FOLDER: {
            title: Texts.General.Modals.UnexistentFolderError.TITLE,
            description: Texts.General.Modals.UnexistentFolderError.DESCRIPTION
        },
    }
}

const Config = {
    SaveConfigs: {
        UNKNOWN_SERVER_ERROR: {
            title: Texts.Config.Modals.SaveConfigsInternalError.TITLE,
            description: Texts.Config.Modals.SaveConfigsInternalError.DESCRIPTION
        }
    }
};

const Main = {
    ValidateDownloadFolder: {
        NO_WRITE_PERMISSION: {
            title: Texts.Main.Modals.DownloadWritingPermissionError.TITLE,
            description: Texts.Main.Modals.DownloadWritingPermissionError.DESCRIPTION
        },
        NO_READ_PERMISSION: {
            title: Texts.Main.Modals.DownloadReadingPermissionError.TITLE,
            description: Texts.Main.Modals.DownloadReadingPermissionError.DESCRIPTION
        },
        UNKNOWN_SERVER_ERROR: {
            title: Texts.Main.Modals.DownloadUseFolderUnknownError.TITLE,
            description: Texts.Main.Modals.DownloadUseFolderUnknownError.DESCRIPTION
        },
        NO_VALID_FOLDER: {
            title: Texts.Main.Modals.DownloadUnexistentFolderError.TITLE,
            description: Texts.Main.Modals.DownloadUnexistentFolderError.DESCRIPTION
        }
    }
};
