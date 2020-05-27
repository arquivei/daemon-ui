package application

import (
	"arquivei.com.br/daemon-ui/client/commands/authenticate"
	"arquivei.com.br/daemon-ui/client/commands/clientinfo"
	"arquivei.com.br/daemon-ui/client/commands/clientstatus"
	"arquivei.com.br/daemon-ui/client/commands/logout"
	"arquivei.com.br/daemon-ui/client/commands/saveconfigs"
	"arquivei.com.br/daemon-ui/client/commands/tour"
	"arquivei.com.br/daemon-ui/client/commands/validateupload"
	"arquivei.com.br/daemon-ui/client/commands/validatedownload"
)

func (app App) doSaveConfigs(uploadFolder, downloadFolder string) (r saveconfigs.Response, err error) {
	data, err := app.c.SendCommand(saveconfigs.NewCommand(uploadFolder, downloadFolder))
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

func (app App) doValidateUploadFolder(path string) (r validateupload.Response, err error) {
	data, err := app.c.SendCommand(validateupload.NewCommand(path))
	if err != nil {
		return r, err
	}

	r, err = validateupload.NewResponse(data)
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

func (app App) doGetClientStatus() (r clientstatus.Response, err error) {
	data, err := app.c.SendCommand(clientstatus.NewCommand())
	if err != nil {
		return r, err
	}

	r, err = clientstatus.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}

func (app App) doUpdateTour() (err error) {
	if _, err := app.c.SendCommand(tour.NewCommand()); err != nil {
		return err
	}
	return nil
}

func (app App) doValidateDownloadFolder(path string) (r validatedownload.Response, err error) {
	data, err := app.c.SendCommand(validatedownload.NewCommand(path))
	if err != nil {
		return r, err
	}

	r, err = validatedownload.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}