package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"bitbucket.org/arquivei/daemon-ui-poc/application"
	"bitbucket.org/arquivei/daemon-ui-poc/client"
	"bitbucket.org/arquivei/daemon-ui-poc/client/commands"
	"github.com/therecipe/qt/core"
	"github.com/therecipe/qt/gui"
	"github.com/therecipe/qt/qml"
	"github.com/therecipe/qt/quick"
)

var appConnection application.Application

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
		log.Println(fmt.Errorf("Error to check is authenticated: %v", err))
	}

	uploadFolder, err := appConnection.GetUploadFolder()
	if err != nil {
		log.Println(fmt.Errorf("Error to get current uplad folder: %v", err))
	}

	bridge.SetIsAuthenticated(isAuthenticated)
	bridge.SetUploadFolderPath(uploadFolder)
}

func authenticate(email string, password string) string {
	response, err := appConnection.Authenticate(email, password)
	if err != nil {
		log.Println(fmt.Errorf("An unknown error occured to authenticate: %v", err))
		response = commands.NewAuthResponseError()
	}
	return response.Encode()
}

func setUploadFolder(folder string) {
	path := core.NewQUrl3(folder, 0).ToLocalFile()
	go func() {
		if err := appConnection.SetUploadFolder(path); err != nil {
			log.Println(fmt.Errorf("An unknown error occured to set update folder: %v", err))
		}
	}()
}

func (bridge *QmlBridge) checkingIsWorking() {
	go func() {
		for range time.NewTicker(time.Second * 2).C {
			isWorking, err := appConnection.IsWorking()
			if err != nil {
				log.Println(fmt.Errorf("An unknown error occured to check is working: %v", err))
			}
			bridge.IsWorking(isWorking)
		}
	}()
}

func main() {
	defer func() {
		if r := recover(); r != nil {
			log.Println("recovered: ", r)
		}
	}()

	f, err := os.OpenFile("daemon-ui.log", os.O_WRONLY|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		panic(fmt.Errorf("An unknown error occured to open the log file: %v", err))
	}

	defer f.Close()

	log.SetOutput(f)

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
