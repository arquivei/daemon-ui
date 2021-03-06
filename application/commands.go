package application

import (
	"arquivei.com.br/daemon-ui/client/commands/authenticate"
	"arquivei.com.br/daemon-ui/client/commands/checkuploadfolders"
	"arquivei.com.br/daemon-ui/client/commands/clientinfo"
	"arquivei.com.br/daemon-ui/client/commands/clientstatus"
	"arquivei.com.br/daemon-ui/client/commands/logout"
	"arquivei.com.br/daemon-ui/client/commands/saveconfigs"
	"arquivei.com.br/daemon-ui/client/commands/tour"
	"arquivei.com.br/daemon-ui/client/commands/validatedownload"
	"arquivei.com.br/daemon-ui/client/commands/validatepermission"
	"arquivei.com.br/daemon-ui/client/commands/validateupload"
)

func (app App) doSaveConfigs(uploadFolders []string, downloadFolder string) (r saveconfigs.Response, err error) {
	data, err := app.c.SendCommand(saveconfigs.NewCommand(uploadFolders, downloadFolder))
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

func (app App) doUpdateTour(tourType string) (err error) {
	if _, err := app.c.SendCommand(tour.NewCommand(tourType)); err != nil {
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

func (app App) doValidatePermission() (r validatepermission.Response, err error) {
	data, err := app.c.SendCommand(validatepermission.NewCommand())
	if err != nil {
		return r, err
	}

	r, err = validatepermission.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}

func (app App) doCheckUploadFolders() (r checkuploadfolders.Response, err error) {
	data, err := app.c.SendCommand(checkuploadfolders.NewCommand())
	if err != nil {
		return r, err
	}

	r, err = checkuploadfolders.NewResponse(data)
	if err != nil {
		return r, err
	}

	return
}
