package application

import (
	"bitbucket.org/arquivei/daemon-ui-poc/client"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands"
)

type App struct {
	c client.Client
}

type Application interface {
	IsWorking() (bool, error)
	GetUploadFolder() (string, error)
	SetUploadFolder(path string) error
	Authenticate(email, password string) (commands.AuthResponse, error)
	IsAuthenticated() (bool, error)
}

func NewAppConnection(c client.Client) Application {
	return &App{
		c: c,
	}
}

func (app App) IsWorking() (isWorking bool, err error) {
	data, err := app.c.SendCommand(
		commands.NewIsWorkingCommand(),
	)
	if err != nil {
		return isWorking, err
	}

	r, err := commands.NewIsWorkingResponse(data)
	if err != nil {
		return isWorking, err
	}

	isWorking = r.IsWorking
	return
}

func (app App) SetUploadFolder(path string) (err error) {
	data, err := app.c.SendCommand(
		commands.NewSetUploadFolderCommand(path),
	)
	if err != nil {
		return err
	}

	_, err = commands.NewSetUploadFolderResponse(data)
	if err != nil {
		return err
	}

	return
}

func (app App) GetUploadFolder() (folder string, err error) {
	data, err := app.c.SendCommand(
		commands.NewGetUploadFolderCommand(),
	)
	if err != nil {
		return folder, err
	}

	r, err := commands.NewGetUploadFolderResponse(data)
	if err != nil {
		return folder, err
	}

	folder = r.UploadFolder
	return
}

func (app App) IsAuthenticated() (isAuth bool, err error) {
	data, err := app.c.SendCommand(
		commands.NewIsAuthenticatedCommand(),
	)
	if err != nil {
		return isAuth, err
	}

	r, err := commands.NewIsAuthenticatedResponse(data)
	if err != nil {
		return isAuth, err
	}

	isAuth = r.IsAuthenticated
	return
}

func (app App) Authenticate(email, password string) (r commands.AuthResponse, err error) {
	data, err := app.c.SendCommand(
		commands.NewAuthenticateCommand(email, password),
	)
	if err != nil {
		return r, err
	}

	r, err = commands.NewAuthResponse(data)
	if err != nil {
		return r, err
	}

	return
}
