package application

import (
	"bitbucket.org/arquivei/daemon-ui-poc/client"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/authenticate"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/getuploadfolder"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/isauthenticated"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/isworking"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/logout"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/ping"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/setuploadfolder"
)

//App contains all application dependencies
type App struct {
	c client.Client
}

//NewAppConnection creates a new server application connection
func NewAppConnection(c client.Client) App {
	return App{c: c}
}

//Logout method logout the current user
func (app App) Logout() (r logout.Response, err error) {
	data, err := app.c.SendCommand(logout.NewCommand())
	if err != nil {
		return r, err
	}

	r, err = logout.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}

//IsWorking method check if the server application is working
func (app App) IsWorking() (isWorking bool, err error) {
	data, err := app.c.SendCommand(isworking.NewCommand())
	if err != nil {
		return isWorking, err
	}

	r, err := isworking.NewResponse(data)
	if err != nil {
		return isWorking, err
	}

	isWorking = r.IsWorking
	return
}

//SetUploadFolder method set the upload folder
func (app App) SetUploadFolder(path string) (r setuploadfolder.Response, err error) {
	data, err := app.c.SendCommand(setuploadfolder.NewCommand(path))
	if err != nil {
		return r, err
	}

	r, err = setuploadfolder.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}

//GetUploadFolder method get the current upload folder
func (app App) GetUploadFolder() (folder string, err error) {
	data, err := app.c.SendCommand(getuploadfolder.NewCommand())
	if err != nil {
		return folder, err
	}

	r, err := getuploadfolder.NewResponse(data)
	if err != nil {
		return folder, err
	}

	folder = r.UploadFolder
	return
}

//IsAuthenticated method verifies if the user is authenticated
func (app App) IsAuthenticated() (isAuth bool, err error) {
	data, err := app.c.SendCommand(isauthenticated.NewCommand())
	if err != nil {
		return isAuth, err
	}

	r, err := isauthenticated.NewResponse(data)
	if err != nil {
		return isAuth, err
	}

	isAuth = r.IsAuthenticated
	return
}

//Authenticate method authenticate an user
func (app App) Authenticate(email, password string) (r authenticate.Response, err error) {
	data, err := app.c.SendCommand(authenticate.NewCommand(email, password))
	if err != nil {
		return r, err
	}

	r, err = authenticate.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}

//Ping method verifies if the server is alive
func (app App) Ping() (err error) {
	_, err = app.c.SendCommand(ping.NewCommand())
	return
}
