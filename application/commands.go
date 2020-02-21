package application

import (
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/authenticate"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/clientinfo"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/logout"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/saveconfigs"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands/validatefolder"
)

func (app App) doSaveConfigs(uploadFolder string) (r saveconfigs.Response, err error) {
	data, err := app.c.SendCommand(saveconfigs.NewCommand(uploadFolder))
	if err != nil {
		return r, err
	}

	r, err = saveconfigs.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}

func (app App) doAuthenticate(email, password string) (r authenticate.Response, err error) {
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

func (app App) doValidateFolder(path string) (r validatefolder.Response, err error) {
	data, err := app.c.SendCommand(validatefolder.NewCommand(path))
	if err != nil {
		return r, err
	}

	r, err = validatefolder.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}

func (app App) doLogout() (r logout.Response, err error) {
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

func (app App) doGetClientInformation() (r clientinfo.Response, err error) {
	data, err := app.c.SendCommand(clientinfo.NewCommand())
	if err != nil {
		return r, err
	}

	r, err = clientinfo.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}
