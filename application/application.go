package application

import (
	"encoding/json"
	"errors"

	"bitbucket.org/arquivei/daemon-ui-poc/client"
)

type App struct {
	client client.AppClient
}

type Application interface {
	IsWorking() (bool, error)
	GetUploadFolder() (string, error)
	SetUploadFolder(path string) error
	Authenticate(email, password string) (client.AuthResponse, error)
	IsAuthenticated() (bool, error)
}

func NewAppConnection(client client.AppClient) Application {
	return &App{
		client: client,
	}
}

func (app App) IsWorking() (bool, error) {
	data, err := app.client.SendCommand(
		client.NewIsWorkingCommand(),
	)
	if err != nil {
		return false, err
	}

	var r client.IsWorkingResponse
	if err := json.Unmarshal(data, &r); err != nil {
		return false, err
	}

	return r.IsWorking, nil
}

func (app App) SetUploadFolder(path string) error {
	data, err := app.client.SendCommand(
		client.NewSetUploadFolderCommand(path),
	)
	if err != nil {
		return err
	}

	var r client.SetUploadFolderResponse
	if err := json.Unmarshal(data, &r); err != nil {
		return err
	}

	return nil
}

func (app App) GetUploadFolder() (string, error) {
	data, err := app.client.SendCommand(
		client.NewGetUploadFolderCommand(),
	)
	if err != nil {
		return "", err
	}

	var r client.GetUploadFolderResponse
	if err := json.Unmarshal(data, &r); err != nil {
		return "", err
	}

	return r.UploadFolder, nil
}

func (app App) IsAuthenticated() (bool, error) {
	data, err := app.client.SendCommand(
		client.NewIsAuthenticatedCommand(),
	)
	if err != nil {
		return false, err
	}

	var r client.IsAuthenticatedResponse
	if err := json.Unmarshal(data, &r); err != nil {
		return false, err
	}

	return r.IsAuthenticated, nil
}

func (app App) Authenticate(email, password string) (r client.AuthResponse, err error) {
	data, err := app.client.SendCommand(
		client.NewAuthenticateCommand(email, password),
	)
	if err != nil {
		return r.ErrorResponse(), err
	}

	if err := json.Unmarshal(data, &r); err != nil {
		return r.ErrorResponse(), err
	}

	if r.Error != "" {
		return r.ErrorResponse(), errors.New(r.Error)
	}

	return
}
