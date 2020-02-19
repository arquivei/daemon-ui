package main

import (
	"os"

	authenticateCmd "bitbucket.org/arquivei/daemon-ui-poc/client/commands/authenticate"
	logoutCmd "bitbucket.org/arquivei/daemon-ui-poc/client/commands/logout"
	setuploadfolderCmd "bitbucket.org/arquivei/daemon-ui-poc/client/commands/setuploadfolder"
	"github.com/therecipe/qt/core"
	"github.com/therecipe/qt/gui"
	"github.com/therecipe/qt/qml"
	"github.com/therecipe/qt/quick"
)

//QmlBridge ...
type QmlBridge struct {
	core.QObject

	_ bool                                        `property:"isAuthenticated"`
	_ string                                      `property:"uploadFolderPath"`
	_ func(email string, password string)         `slot:"authenticate"`
	_ func()                                      `slot:"logout"`
	_ func(folder string)                         `slot:"setUploadFolder"`
	_ func(success bool, code, folderPath string) `signal:"setUploadFolderSignal"`
	_ func(success bool, message string)          `signal:"authenticateSignal"`
	_ func(success bool, code string)             `signal:"logoutSignal"`
	_ func()                                      `constructor:"init"`
}

func (bridge *QmlBridge) init() {
	isAuthenticated, err := r.appConnection.IsAuthenticated()
	if err != nil {
		r.logger.WithError(err).Error("An unknown error occurred while checking is authenticated")
	}

	uploadFolder, err := r.appConnection.GetUploadFolder()
	if err != nil {
		r.logger.WithError(err).Error("An unknown error occurred while getting the current upload folder")
	}

	bridge.SetIsAuthenticated(isAuthenticated)
	bridge.SetUploadFolderPath(uploadFolder)
}

func authenticate(email string, password string) (resp authenticateCmd.Response) {
	resp, err := r.appConnection.Authenticate(email, password)
	if err != nil {
		r.logger.WithError(err).Error("An unknown error occurred to authenticate")
		resp = authenticateCmd.NewGenericError()
	}
	return
}

func logout() (resp logoutCmd.Response) {
	resp, err := r.appConnection.Logout()
	if err != nil {
		r.logger.WithError(err).Error("An unknown error occurred to logout")
		resp = logoutCmd.NewGenericError()
	}
	return
}

func setUploadFolder(folder string) (resp setuploadfolderCmd.Response) {
	resp, err := r.appConnection.SetUploadFolder(folder)
	if err != nil {
		r.logger.WithError(err).Error("An unknown error occurred while setting the update folder")
		resp = setuploadfolderCmd.NewGenericError()
	}
	return
}

func newGuiInterface() {
	// Force the software backend always.
	quick.QQuickWindow_SetSceneGraphBackend(quick.QSGRendererInterface__Software)

	core.QCoreApplication_SetOrganizationName("Arquivei")

	gui.NewQGuiApplication(len(os.Args), os.Args)

	var qmlBridge = NewQmlBridge(nil)

	var app = qml.NewQQmlApplicationEngine(nil)
	app.RootContext().SetContextProperty("QmlBridge", qmlBridge)
	app.Load(core.NewQUrl3("qrc:/qml/main.qml", 0))

	qmlBridge.ConnectAuthenticate(func(email string, password string) {
		go func() {
			resp := authenticate(email, password)
			qmlBridge.AuthenticateSignal(resp.Success, resp.Message)
		}()
	})

	qmlBridge.ConnectLogout(func() {
		go func() {
			resp := logout()
			qmlBridge.LogoutSignal(resp.Success, resp.Code)
		}()
	})

	qmlBridge.ConnectSetUploadFolder(func(folder string) {
		go func() {
			folder = core.NewQUrl3(folder, 0).ToLocalFile()
			resp := setUploadFolder(folder)
			qmlBridge.SetUploadFolderSignal(resp.Success, resp.Code, folder)
		}()
	})

	gui.QGuiApplication_Exec()
}
