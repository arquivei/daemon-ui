package main

import (
	"os"
	"time"

	authenticateCmd "bitbucket.org/arquivei/daemon-ui-poc/client/commands/authenticate"
	setuploadfolderCmd "bitbucket.org/arquivei/daemon-ui-poc/client/commands/setuploadfolder"
	"github.com/therecipe/qt/core"
	"github.com/therecipe/qt/gui"
	"github.com/therecipe/qt/qml"
	"github.com/therecipe/qt/quick"
)

//QmlBridge ...
type QmlBridge struct {
	core.QObject

	_ bool                                       `property:"isAuthenticated"`
	_ string                                     `property:"uploadFolderPath"`
	_ func(email string, password string) string `slot:"authenticate"`
	_ func(folder string) string                 `slot:"setUploadFolder"`
	_ func(isWorking bool)                       `signal:"isWorking"`
	_ func()                                     `constructor:"init"`
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

func authenticate(email string, password string) string {
	response, err := r.appConnection.Authenticate(email, password)
	if err != nil {
		r.logger.WithError(err).Error("An unknown error occurred to authenticate")
		response = authenticateCmd.NewGenericError()
	}
	return response.Encode()
}

func setUploadFolder(folder string) string {
	selectedPath := core.NewQUrl3(folder, 0).ToLocalFile()
	response, err := r.appConnection.SetUploadFolder(selectedPath)
	if err != nil {
		r.logger.WithError(err).Error("An unknown error occurred while setting the update folder")
		response = setuploadfolderCmd.NewGenericError()
	}
	return response.Encode()
}

func (bridge *QmlBridge) checkingIsWorking() {
	go func() {
		for range time.NewTicker(time.Second * 2).C {
			isWorking, err := r.appConnection.IsWorking()
			if err != nil {
				r.logger.WithError(err).Error("An unknown error occurred while checking is working")
			}
			bridge.IsWorking(isWorking)
		}
	}()
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

	qmlBridge.ConnectAuthenticate(func(email string, password string) string {
		return authenticate(email, password)
	})

	qmlBridge.ConnectSetUploadFolder(func(folder string) string {
		return setUploadFolder(folder)
	})

	qmlBridge.checkingIsWorking()

	gui.QGuiApplication_Exec()
}
