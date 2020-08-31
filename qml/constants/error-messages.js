.import "texts.js" as Texts

const General = {
    CheckDownloadPermission: {
        UNKNOWN_SERVER_ERROR: {
            title: Texts.General.Modals.CheckDownloadPermissionError.TITLE,
            description: Texts.General.Modals.CheckDownloadPermissionError.DESCRIPTION,
        }
    }
}

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
    },
    ValidateUploadFolder: {
        NO_WRITE_PERMISSION: {
            title: Texts.Main.Modals.UploadWritingPermissionError.TITLE,
            description: Texts.Main.Modals.UploadWritingPermissionError.DESCRIPTION
        },
        NO_READ_PERMISSION: {
            title: Texts.Main.Modals.UploadReadingPermissionError.TITLE,
            description: Texts.Main.Modals.UploadReadingPermissionError.DESCRIPTION
        },
        UNKNOWN_SERVER_ERROR: {
            title: Texts.Main.Modals.UploadUseFolderUnknownError.TITLE,
            description: Texts.Main.Modals.UploadUseFolderUnknownError.DESCRIPTION
        },
        NO_VALID_FOLDER: {
            title: Texts.Main.Modals.UploadUnexistentFolderError.TITLE,
            description: Texts.Main.Modals.UploadUnexistentFolderError.DESCRIPTION
        }
    }
};
