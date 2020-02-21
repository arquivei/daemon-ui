package application

import (
	"bitbucket.org/arquivei/daemon-ui-poc/client"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/authenticate"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/clientinfo"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/logout"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/ping"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/saveconfigs"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/validatefolder"
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
func (app App) SaveConfigs(uploadFolder string) (r saveconfigs.Response) {
	r, err := app.doSaveConfigs(uploadFolder)
	if err != nil {
		app.logger.
			WithError(err).
			WithField("uploadFolder", uploadFolder).
			Error("An error occurred while saving user configs")
		r = saveconfigs.NewGenericError()
	}
	return
}

//Authenticate method authenticate an user
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
	_, err = app.c.SendCommand(ping.NewCommand())
	return
}

//ValidateFolder method should validate a folder
func (app App) ValidateFolder(path string) (r validatefolder.Response) {
	r, err := app.doValidateFolder(path)
	if err != nil {
		app.logger.
			WithError(err).
			WithField("path", path).
			Error("An unknown error occurred while validating the folder")
		r = validatefolder.NewGenericError()
	}
	return
}

//GetClientInformation method get informations about the client
func (app App) GetClientInformation() (r clientinfo.Response) {
	r, err := app.doGetClientInformation()
	if err != nil {
		app.logger.
			WithError(err).
			Error("An unknown error occurred while getting client information")
	}
	return
}
