package application

import (
	"arquivei.com.br/daemon-ui/client"
	"arquivei.com.br/daemon-ui/client/commands/authenticate"
	"arquivei.com.br/daemon-ui/client/commands/clientinfo"
	"arquivei.com.br/daemon-ui/client/commands/clientstatus"
	"arquivei.com.br/daemon-ui/client/commands/logout"
	"arquivei.com.br/daemon-ui/client/commands/saveconfigs"
	"arquivei.com.br/daemon-ui/client/commands/validatedownload"
	"arquivei.com.br/daemon-ui/client/commands/validateupload"
	"github.com/sirupsen/logrus"
)

//App contains all application dependencies
type App struct {
	c      client.Client
	logger *logrus.Entry
}

//NewAppConnection creates a new server application connection
func NewAppConnection(c client.Client, logger *logrus.Entry) App {
	return App{
		c:      c,
		logger: logger,
	}
}

//Logout method logout the current user
func (app App) Logout() (r logout.Response) {
	r, err := app.doLogout()
	if err != nil {
		app.logger.
			WithError(err).
			Error("An error occurred while logouting")
		r = logout.NewGenericError()
	}
	return
}

//SaveConfigs method saves the user configs
func (app App) SaveConfigs(uploadFolders []string, downloadFolder string) (r saveconfigs.Response) {
	r, err := app.doSaveConfigs(uploadFolders, downloadFolder)
	if err != nil {
		app.logger.
			WithError(err).
			WithField("upload_folders", uploadFolders).
			WithField("download_folder", downloadFolder).
			Error("An error occurred while saving user configs")
		r = saveconfigs.NewGenericError()
	}
	return
}

//Authenticate method authenticates an user
func (app App) Authenticate(email, password string) (r authenticate.Response) {
	r, err := app.doAuthenticate(email, password)
	if err != nil {
		app.logger.
			WithError(err).
			WithField("email", email).
			Error("An error occurred while authenticating")
		r = authenticate.NewGenericError()
	}
	return
}

//Ping method verifies if the server is alive
func (app App) Ping() (err error) {
	_, err = app.doGetClientStatus()
	return
}

//ValidateUploadFolder method validates a folder
func (app App) ValidateUploadFolder(path string) (r validateupload.Response) {
	r, err := app.doValidateUploadFolder(path)
	if err != nil {
		app.logger.
			WithError(err).
			WithField("path", path).
			Error("An unknown error occurred while validating the upload folder")
		r = validateupload.NewGenericError()
	}
	return
}

//GetClientInformation method returns informations about the client
func (app App) GetClientInformation() (r clientinfo.Response) {
	r, err := app.doGetClientInformation()
	if err != nil {
		app.logger.
			WithError(err).
			Error("An unknown error occurred while getting client information")
	}
	return
}

//GetClientStatus method returns the client status
func (app App) GetClientStatus() (r clientstatus.Response) {
	r, err := app.doGetClientStatus()
	if err != nil {
		app.logger.
			WithError(err).
			Error("An unknown error occurred while getting client status")
		r = clientstatus.NewGenericError()
	}
	return
}

//UpdateTour method updates the tour status
func (app App) UpdateTour() {
	if err := app.doUpdateTour(); err != nil {
		app.logger.
			WithError(err).
			Error("An error occurred while updating main tour")
	}
}

//ValidateDownloadFolder method validates a folder
func (app App) ValidateDownloadFolder(path string) (r validatedownload.Response) {
	r, err := app.doValidateDownloadFolder(path)
	if err != nil {
		app.logger.
			WithError(err).
			WithField("path", path).
			Error("An unknown error occurred while validating the download folder")
		r = validatedownload.NewGenericError()
	}
	return
}
