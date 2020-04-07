package main

import (
	"os"
	"strings"
	"time"

	"arquivei.com.br/daemon-ui/impl/file"
	"github.com/therecipe/qt/core"
	"github.com/therecipe/qt/gui"
	"github.com/therecipe/qt/qml"
)

//QmlBridge ...
type QmlBridge struct {
	core.QObject

	_ bool                                                                           `property:"isAuthenticated"`
	_ string                                                                         `property:"uploadFolderPath"`
	_ string                                                                         `property:"hostName"`
	_ string                                                                         `property:"userEmail"`
	_ string                                                                         `property:"webDetailLink"`
	_ string                                                                         `property:"logsPath"`
	_ string                                                                         `property:"macAddress"`
	_ bool                                                                           `property:"isMainTourViewed"`
	_ func(email string, password string)                                            `slot:"authenticate"`
	_ func()                                                                         `slot:"logout"`
	_ func(uploadFolder string)                                                      `slot:"saveConfigs"`
	_ func(folder string)                                                            `slot:"validateFolder"`
	_ func()                                                                         `slot:"setMainTourIsViewed"`
	_ func(success bool, code string)                                                `signal:"saveConfigsSignal"`
	_ func(success bool, code, folder string)                                        `signal:"validateFolderSignal"`
	_ func(success bool, message string)                                             `signal:"authenticateSignal"`
	_ func(success bool, code string)                                                `signal:"logoutSignal"`
	_ func(processingStatus string, totalSent int, total int, hasDocumentError bool) `signal:"clientStatusSignal"`
	_ func()                                                                         `constructor:"init"`
}

func (bridge *QmlBridge) init() {
	clientInformation := r.appConnection.GetClientInformation()

	bridge.SetUserEmail(clientInformation.UserEmail)
	bridge.SetHostName(clientInformation.ClientHostname)
	bridge.SetWebDetailLink(clientInformation.ClientWebDetailLink)
	bridge.SetIsAuthenticated(clientInformation.IsAuthenticated)
	bridge.SetUploadFolderPath(clientInformation.UploadFolder)
	bridge.SetLogsPath(file.GetURIScheme() + clientInformation.LogsPath)
	bridge.SetIsMainTourViewed(clientInformation.IsTourViewed)
	bridge.SetMacAddress(r.macAddress)
}

func newGuiInterface() {
	//needed to get the application working on VMs when using the windows docker images
	//quick.QQuickWindow_SetSceneGraphBackend(quick.QSGRendererInterface__Software)

	//needed to fix an QML Settings issue on windows
	core.QCoreApplication_SetOrganizationName("Arquivei")

	gui.NewQGuiApplication(len(os.Args), os.Args)

	var qmlBridge = NewQmlBridge(nil)

	var app = qml.NewQQmlApplicationEngine(nil)
	app.RootContext().SetContextProperty("QmlBridge", qmlBridge)
	app.Load(core.NewQUrl3("qrc:/qml/main.qml", 0))

	qmlBridge.ConnectAuthenticate(func(email string, password string) {
		go func() {
			authRespesponse := r.appConnection.Authenticate(email, password)
			clientInformation := r.appConnection.GetClientInformation()
			qmlBridge.AuthenticateSignal(authRespesponse.Success, authRespesponse.Message)
			qmlBridge.SetUserEmail(clientInformation.UserEmail)
			qmlBridge.SetHostName(clientInformation.ClientHostname)
			qmlBridge.SetWebDetailLink(clientInformation.ClientWebDetailLink)
			qmlBridge.SetIsAuthenticated(clientInformation.IsAuthenticated)
			qmlBridge.SetMacAddress(r.macAddress)
		}()
	})

	qmlBridge.ConnectLogout(func() {
		go func() {
			resp := r.appConnection.Logout()
			qmlBridge.LogoutSignal(resp.Success, resp.Code)
		}()
	})

	qmlBridge.ConnectSaveConfigs(func(uploadFolder string) {
		go func() {
			uploadFolder = formatFolderPath(uploadFolder)
			resp := r.appConnection.SaveConfigs(uploadFolder)
			qmlBridge.SaveConfigsSignal(resp.Success, resp.Code)
			qmlBridge.SetUploadFolderPath(uploadFolder)
		}()
	})

	qmlBridge.ConnectValidateFolder(func(folder string) {
		go func() {
			folder = formatFolderPath(folder)
			resp := r.appConnection.ValidateFolder(folder)
			qmlBridge.ValidateFolderSignal(resp.Success, resp.Code, folder)
		}()
	})

	qmlBridge.ConnectSetMainTourIsViewed(func() {
		go func() {
			r.appConnection.UpdateTour()
			qmlBridge.SetIsMainTourViewed(true)
		}()
	})

	go func() {
		for range time.NewTicker(time.Second * 5).C {
			clientStatus := r.appConnection.GetClientStatus()
			qmlBridge.ClientStatusSignal(
				clientStatus.ProcessingStatus,
				clientStatus.TotalSent,
				clientStatus.TotalDocuments,
				clientStatus.HasDocumentError,
			)

			clientInformation := r.appConnection.GetClientInformation()
			qmlBridge.SetIsAuthenticated(clientInformation.IsAuthenticated)
			qmlBridge.SetWebDetailLink(clientInformation.ClientWebDetailLink)
		}
	}()

	gui.QGuiApplication_Exec()
}

func formatFolderPath(path string) string {
	return strings.Replace(path, file.GetURIScheme(), "", -1)
}
