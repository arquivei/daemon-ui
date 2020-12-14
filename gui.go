package main

import (
	"encoding/json"
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

//QmlBridge struct is an interface to comunicate with the QML
type QmlBridge struct {
	core.QObject

	_ bool                                                                           `property:"isAuthenticated"`
	_ bool                                                                           `property:"canDownload"`
	_ string                                                                         `property:"uploadFolderPaths"`
	_ string                                                                         `property:"downloadFolderPath"`
	_ string                                                                         `property:"hostName"`
	_ string                                                                         `property:"userEmail"`
	_ string                                                                         `property:"webDetailLink"`
	_ string                                                                         `property:"logsPath"`
	_ string                                                                         `property:"macAddress"`
	_ bool                                                                           `property:"isMainTourViewed"`
	_ bool                                                                           `property:"isConfigTourViewed"`
	_ func(email string, password string)                                            `slot:"authenticate"`
	_ func()                                                                         `slot:"logout"`
	_ func(uploadFolder []string, downloadFolder string)                             `slot:"saveConfigs"`
	_ func(folder string)                                                            `slot:"validateUploadFolder"`
	_ func(folder string)                                                            `slot:"validateDownloadFolder"`
	_ func()                                                                         `slot:"setMainTourIsViewed"`
	_ func()                                                                         `slot:"setConfigTourIsViewed"`
	_ func()                                                                         `slot:"checkDownloadPermission"`
	_ func()                                                                         `slot:"checkUploadFolders"`
	_ func(success bool, code string)                                                `signal:"saveConfigsSignal"`
	_ func(success bool, code, folder string)                                        `signal:"validateUploadFolderSignal"`
	_ func(success bool, code, folder string)                                        `signal:"validateDownloadFolderSignal"`
	_ func(success bool, message string)                                             `signal:"authenticateSignal"`
	_ func(success bool, code string)                                                `signal:"logoutSignal"`
	_ func(processingStatus string, totalSent int, total int, hasDocumentError bool) `signal:"uploadStatusSignal"`
	_ func(processingStatus string, totalDownloaded int)                             `signal:"downloadStatusSignal"`
	_ func()                                                                         `signal:"showMainWindowSignal"`
	_ func(code string)                                                              `signal:"downloadPermissionSignal"`
	_ func()                                                                         `constructor:"init"`
}

//Folder struct represents a upload folder object
type Folder struct {
	Code string `json:"code"`
	Path string `json:"path"`
}

func (bridge *QmlBridge) init() {
	clientInformation := r.appConnection.GetClientInformation()

	bridge.SetUserEmail(clientInformation.UserEmail)
	bridge.SetHostName(clientInformation.ClientHostname)
	bridge.SetWebDetailLink(clientInformation.ClientWebDetailLink)
	bridge.SetIsAuthenticated(clientInformation.IsAuthenticated)
	bridge.SetDownloadFolderPath(clientInformation.DownloadFolder)
	bridge.SetLogsPath(file.GetURIScheme() + clientInformation.LogsPath)
	bridge.SetIsMainTourViewed(clientInformation.IsMainTourViewed)
	bridge.SetIsConfigTourViewed(clientInformation.IsConfigTourViewed)
	bridge.SetCanDownload(clientInformation.CanDownload)
	bridge.SetMacAddress(r.macAddress)
	bridge.setUploadFolderPaths(clientInformation.UploadFolders)
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
	bridge.SetCanDownload(clientInformation.CanDownload)
}

func (bridge *QmlBridge) setUploadFolderPaths(paths []string) {
	var folders []Folder
	for _, path := range paths {
		folders = append(folders, Folder{Path: path})
	}
	bridge.SetUploadFolderPaths(convertToString(folders))
}

func (bridge *QmlBridge) setUploadFolders(folders []Folder) {
	bridge.SetUploadFolderPaths(convertToString(folders))
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
			qmlBridge.SetDownloadFolderPath("")
			qmlBridge.setUploadFolderPaths([]string{})
		}()
	})

	qmlBridge.ConnectSaveConfigs(func(uploadFolders []string, downloadFolder string) {
		go func() {
			uploadFolders := formatFolderPaths(uploadFolders)
			resp := r.appConnection.SaveConfigs(uploadFolders, downloadFolder)
			qmlBridge.SaveConfigsSignal(resp.Success, resp.Code)
			qmlBridge.SetDownloadFolderPath(downloadFolder)
			qmlBridge.setUploadFolderPaths(uploadFolders)
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
			r.appConnection.UpdateMainTourStatus()
			qmlBridge.SetIsMainTourViewed(true)
		}()
	})

	qmlBridge.ConnectSetConfigTourIsViewed(func() {
		go func() {
			r.appConnection.UpdateConfigTourStatus()
			qmlBridge.SetIsConfigTourViewed(true)
		}()
	})

	qmlBridge.ConnectCheckDownloadPermission(func() {
		go func() {
			resp := r.appConnection.ValidatePermission()
			qmlBridge.DownloadPermissionSignal(resp.Code)
			qmlBridge.SetCanDownload(resp.Code == "DOWNLOAD_ALLOWED")
		}()
	})

	qmlBridge.ConnectCheckUploadFolders(func() {
		go func() {
			var foldersToUpdate []Folder
			var foldersToReset []Folder

			for _, item := range r.appConnection.CheckUploadFolders().Folders {
				foldersToUpdate = append(foldersToUpdate, Folder{Path: item.Path, Code: item.Code})
				foldersToReset = append(foldersToReset, Folder{Path: item.Path})
			}

			//Force reset upload folders on QML
			qmlBridge.setUploadFolders(foldersToReset)
			qmlBridge.setUploadFolders(foldersToUpdate)
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

func formatFolderPaths(paths []string) []string {
	var formatedPaths []string
	for _, path := range paths {
		formatedPaths = append(formatedPaths, formatFolderPath(path))
	}
	return formatedPaths
}

func convertToString(folders []Folder) string {
	b, _ := json.Marshal(folders)
	return string(b)
}
