package client

type CommandName string

const (
	authenticateCmd    = "AUTHENTICATE_CMD"
	isAuthenticatedCmd = "IS_AUTHENTICADED_CMD"
	getUploadFolderCmd = "GET_UPLOAD_FOLDER_CMD"
	setUploadFolderCmd = "SET_UPLOAD_FOLDER_CMD"
	isWorkingCmd       = "IS_WORKING_CMD"
)

type CommandInterface interface {
	Encode() (string, error)
}
