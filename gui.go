package main

import (
	"os"

	"github.com/therecipe/qt/core"
	"github.com/therecipe/qt/gui"
	"github.com/therecipe/qt/qml"
)

//QmlBridge ...
type QmlBridge struct {
	core.QObject

	_ bool                                    `property:"isAuthenticated"`
	_ string                                  `property:"uploadFolderPath"`
	_ string                                  `property:"hostName"`
	_ string                                  `property:"userEmail"`
	_ string                                  `property:"webDetailLink"`
	_ func(email string, password string)     `slot:"authenticate"`
	_ func()                                  `slot:"logout"`
	_ func(uploadFolder string)               `slot:"saveConfigs"`
	_ func(folder string)                     `slot:"validateFolder"`
	_ func(success bool, code string)         `signal:"saveConfigsSignal"`
	_ func(success bool, code, folder string) `signal:"validateFolderSignal"`
	_ func(success bool, message string)      `signal:"authenticateSignal"`
	_ func(success bool, code string)         `signal:"logoutSignal"`
	_ func()                                  `constructor:"init"`
}

func (bridge *QmlBridge) init() {
	clientInformation := r.appConnection.GetClientInformation()

	bridge.SetUserEmail(clientInformation.UserEmail)
	bridge.SetHostName(clientInformation.ClientHostname)
	bridge.SetWebDetailLink(clientInformation.ClientWebDetailLink)
	bridge.SetIsAuthenticated(clientInformation.IsAuthenticated)
	bridge.SetUploadFolderPath(clientInformation.UploadFolder)
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
			resp := r.appConnection.SaveConfigs(uploadFolder)
			qmlBridge.SaveConfigsSignal(resp.Success, resp.Code)
		}()
	})

	qmlBridge.ConnectValidateFolder(func(folder string) {
		go func() {
			folder = core.NewQUrl3(folder, 0).ToLocalFile()
			resp := r.appConnection.ValidateFolder(folder)
			qmlBridge.ValidateFolderSignal(resp.Success, resp.Code, folder)
		}()
	})

	gui.QGuiApplication_Exec()
}
