package main

import (
	"os"
	"runtime/debug"
	"time"

	"bitbucket.org/arquivei/daemon-ui-poc/application"
	"bitbucket.org/arquivei/daemon-ui-poc/client"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands"
	log "github.com/sirupsen/logrus"
	"github.com/therecipe/qt/core"
	"github.com/therecipe/qt/gui"
	"github.com/therecipe/qt/qml"
	"github.com/therecipe/qt/quick"
)

var appConnection application.Application
var logger *log.Entry

type QmlBridge struct {
	core.QObject

	_ bool                                       `property:"isAuthenticated"`
	_ string                                     `property:"uploadFolderPath"`
	_ func(email string, password string) string `slot:"authenticate"`
	_ func(folder string)                        `slot:"setUploadFolder"`
	_ func(isWorking bool)                       `signal:"isWorking"`
	_ func()                                     `constructor:"init"`
}

func (bridge *QmlBridge) init() {
	isAuthenticated, err := appConnection.IsAuthenticated()
	if err != nil {
		logger.WithError(err).Error("Error to check is authenticated")
	}

	uploadFolder, err := appConnection.GetUploadFolder()
	if err != nil {
		logger.WithError(err).Error("Error to get current uplad folder")
	}

	bridge.SetIsAuthenticated(isAuthenticated)
	bridge.SetUploadFolderPath(uploadFolder)
}

func authenticate(email string, password string) string {
	response, err := appConnection.Authenticate(email, password)
	if err != nil {
		logger.WithError(err).Error("An unknown error occured to authenticate")
		response = commands.NewAuthResponseError()
	}
	return response.Encode()
}

func setUploadFolder(folder string) {
	path := core.NewQUrl3(folder, 0).ToLocalFile()
	go func() {
		if err := appConnection.SetUploadFolder(path); err != nil {
			logger.WithError(err).Error("An unknown error occured to set update folder")
		}
	}()
}

func (bridge *QmlBridge) checkingIsWorking() {
	go func() {
		for range time.NewTicker(time.Second * 2).C {
			isWorking, err := appConnection.IsWorking()
			if err != nil {
				logger.WithError(err).Error("An unknown error occured to check is working")
			}
			bridge.IsWorking(isWorking)
		}
	}()
}

func main() {
	defer func() {
		if r := recover(); r != nil {
			log.WithField("error", r).
				WithField("stacktrace", string(debug.Stack())).
				Error("Recovered from panic! Closing application.")
		}
	}()

	hostname, _ := os.Hostname()

	logger = log.WithFields(log.Fields{
		"beat.name":     "DAEMON",
		"beat.hostname": hostname,
	})

	log.SetLevel(log.DebugLevel)

	appConnection = application.NewAppConnection(
		client.NewClient(),
	)

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

	qmlBridge.ConnectSetUploadFolder(func(folder string) {
		setUploadFolder(folder)
	})

	qmlBridge.checkingIsWorking()

	gui.QGuiApplication_Exec()
}
