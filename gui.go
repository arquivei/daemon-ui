package main

import (
	"os"
	"strings"
	"time"

	"arquivei.com.br/daemon-ui/client/commands/clientstatus"
	"arquivei.com.br/daemon-ui/impl/file"
	"github.com/therecipe/qt/core"
	"github.com/therecipe/qt/gui"
	"github.com/therecipe/qt/qml"
	"github.com/therecipe/qt/widgets"
)

//QmlBridge ...
type QmlBridge struct {
	core.QObject

	_ bool                                                                           `property:"isAuthenticated"`
	_ bool                                                                           `property:"canDownload"`
	_ string                                                                         `property:"uploadFolderPath"`
	_ string                                                                         `property:"downloadFolderPath"`
	_ string                                                                         `property:"hostName"`
	_ string                                                                         `property:"userEmail"`
	_ string                                                                         `property:"webDetailLink"`
	_ string                                                                         `property:"logsPath"`
	_ string                                                                         `property:"macAddress"`
	_ bool                                                                           `property:"isMainTourViewed"`
	_ func(email string, password string)                                            `slot:"authenticate"`
	_ func()                                                                         `slot:"logout"`
	_ func(uploadFolder, downloadFolder string)                                      `slot:"saveConfigs"`
	_ func(folder string)                                                            `slot:"validateUploadFolder"`
	_ func(folder string)                                                            `slot:"validateDownloadFolder"`
	_ func()                                                                         `slot:"setMainTourIsViewed"`
	_ func(success bool, code string)                                                `signal:"saveConfigsSignal"`
	_ func(success bool, code, folder string)                                        `signal:"validateUploadFolderSignal"`
	_ func(success bool, code, folder string)                                        `signal:"validateDownloadFolderSignal"`
	_ func(success bool, message string)                                             `signal:"authenticateSignal"`
	_ func(success bool, code string)                                                `signal:"logoutSignal"`
	_ func(processingStatus string, totalSent int, total int, hasDocumentError bool) `signal:"uploadStatusSignal"`
	_ func(processingStatus string, totalDownloaded int)                             `signal:"downloadStatusSignal"`
	_ func()                                                                         `signal:"showMainWindowSignal"`
	_ func()                                                                         `constructor:"init"`
}

func (bridge *QmlBridge) init() {
	clientInformation := r.appConnection.GetClientInformation()

	bridge.SetUserEmail(clientInformation.UserEmail)
	bridge.SetHostName(clientInformation.ClientHostname)
	bridge.SetWebDetailLink(clientInformation.ClientWebDetailLink)
	bridge.SetIsAuthenticated(clientInformation.IsAuthenticated)
	bridge.SetUploadFolderPath(clientInformation.UploadFolder)
	bridge.SetDownloadFolderPath(clientInformation.DownloadFolder)
	bridge.SetLogsPath(file.GetURIScheme() + clientInformation.LogsPath)
	bridge.SetIsMainTourViewed(clientInformation.IsTourViewed)
	bridge.SetCanDownload(clientInformation.CanDownload)
	bridge.SetMacAddress(r.macAddress)
}

func (bridge *QmlBridge) syncStatus(clientStatus clientstatus.Response) {
	bridge.UploadStatusSignal(
		clientStatus.Upload.ProcessingStatus,
		clientStatus.Upload.TotalSent,
		clientStatus.Upload.TotalDocuments,
		clientStatus.Upload.HasDocumentError,
	)

	bridge.DownloadStatusSignal(
		clientStatus.Download.ProcessingStatus,
		clientStatus.Download.TotalDownloaded,
	)

	clientInformation := r.appConnection.GetClientInformation()
	bridge.SetIsAuthenticated(clientInformation.IsAuthenticated)
	bridge.SetWebDetailLink(clientInformation.ClientWebDetailLink)
}

func newGuiInterface() {
	//needed to get the application working on VMs when using the windows docker images
	//quick.QQuickWindow_SetSceneGraphBackend(quick.QSGRendererInterface__Software)

	//needed to fix an QML Settings issue on windows
	core.QCoreApplication_SetOrganizationName("Arquivei")

	app := widgets.NewQApplication(len(os.Args), os.Args)
	app.SetWindowIcon(gui.NewQIcon5("favicon.ico"))

	var qmlBridge = NewQmlBridge(nil)

	var engine = qml.NewQQmlApplicationEngine(nil)
	engine.RootContext().SetContextProperty("QmlBridge", qmlBridge)
	engine.Load(core.NewQUrl3("qrc:/qml/main.qml", 0))

	systray := NewQSystemTrayIconCustomSlot(nil)
	systray.SetIcon(app.WindowIcon())

	var systrayMenu = widgets.NewQMenu(nil)
	var openAction = systrayMenu.AddAction("Abrir")
	var exitAction = systrayMenu.AddAction("Sair")

	systray.SetContextMenu(systrayMenu)
	systray.Show()

	systray.ShowMessage(systemTrayTitle, "Iniciando aplicativo...", widgets.QSystemTrayIcon__Information, 5000)

	openAction.ConnectTriggered(func(checked bool) {
		go func() {
			qmlBridge.ShowMainWindowSignal()
		}()
	})

	exitAction.ConnectTriggered(func(checked bool) {
		app.Quit()
	})

	qmlBridge.ConnectAuthenticate(func(email string, password string) {
		go func() {
			authRespesponse := r.appConnection.Authenticate(email, password)
			clientInformation := r.appConnection.GetClientInformation()
			qmlBridge.AuthenticateSignal(authRespesponse.Success, authRespesponse.Message)
			qmlBridge.SetUserEmail(clientInformation.UserEmail)
			qmlBridge.SetHostName(clientInformation.ClientHostname)
			qmlBridge.SetWebDetailLink(clientInformation.ClientWebDetailLink)
			qmlBridge.SetIsAuthenticated(clientInformation.IsAuthenticated)
			qmlBridge.SetCanDownload(clientInformation.CanDownload)
			qmlBridge.SetMacAddress(r.macAddress)
		}()
	})

	qmlBridge.ConnectLogout(func() {
		go func() {
			resp := r.appConnection.Logout()
			qmlBridge.LogoutSignal(resp.Success, resp.Code)
		}()
	})

	qmlBridge.ConnectSaveConfigs(func(uploadFolder, downloadFolder string) {
		go func() {
			uploadFolder = formatFolderPath(uploadFolder)
			resp := r.appConnection.SaveConfigs(uploadFolder, downloadFolder)
			qmlBridge.SaveConfigsSignal(resp.Success, resp.Code)
			qmlBridge.SetUploadFolderPath(uploadFolder)
			qmlBridge.SetDownloadFolderPath(downloadFolder)
		}()
	})

	qmlBridge.ConnectValidateUploadFolder(func(folder string) {
		go func() {
			folder = formatFolderPath(folder)
			resp := r.appConnection.ValidateUploadFolder(folder)
			qmlBridge.ValidateUploadFolderSignal(resp.Success, resp.Code, folder)
		}()
	})

	qmlBridge.ConnectValidateDownloadFolder(func(folder string) {
		go func() {
			folder = formatFolderPath(folder)
			resp := r.appConnection.ValidateDownloadFolder(folder)
			qmlBridge.ValidateDownloadFolderSignal(resp.Success, resp.Code, folder)
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
			qmlBridge.syncStatus(clientStatus)
			systray.showDownloadStatus(clientStatus)
			systray.showUploadStatus(clientStatus)
		}
	}()

	widgets.QApplication_Exec()
}

func formatFolderPath(path string) string {
	for _, uriScheme := range file.GetAvailableSchemes() {
		path = strings.ReplaceAll(path, uriScheme, "")
	}
	return path
}
