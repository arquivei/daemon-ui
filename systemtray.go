package main

import (
	"runtime/debug"

	"arquivei.com.br/daemon-ui/client/commands/clientstatus"
	log "github.com/sirupsen/logrus"
	"github.com/therecipe/qt/widgets"
)

const systemTrayTitle = "Sincroniza Notas"

const (
	statusProcessing      = "STATUS_PROCESSING"
	statusFinished        = "STATUS_FINISHED"
	statusErrorConnection = "STATUS_ERROR_CONNECTION"
)

//QSystemTrayIconCustomSlot ...
type QSystemTrayIconCustomSlot struct {
	widgets.QSystemTrayIcon
	InternetConnectionTrayViewed bool
	DownloadCompletedTrayViewed  bool
	UploadCompletedTrayViewed    bool

	_ func(f func()) `slot:"triggerSlot,auto"`
}

//triggerSlot just needs to call the passed function to execute it inside the main thread
func (tray *QSystemTrayIconCustomSlot) triggerSlot(f func()) {
	defer func() {
		if r := recover(); r != nil {
			log.WithField("error", r).
				WithField("stacktrace", string(debug.Stack())).
				Error("[SystemTray::triggerSlot] Recovered from panic!")
		}
	}()

	f()
}

func (tray *QSystemTrayIconCustomSlot) showDownloadStatus(clientStatus clientstatus.Response) {
	var message string
	var icon widgets.QSystemTrayIcon__MessageIcon

	switch clientStatus.Download.ProcessingStatus {
	case statusProcessing:
		tray.InternetConnectionTrayViewed = false
		tray.DownloadCompletedTrayViewed = false
		return
	case statusFinished:
		if tray.DownloadCompletedTrayViewed {
			return
		}
		message = "O download dos documentos terminou"
		icon = widgets.QSystemTrayIcon__Information
		tray.DownloadCompletedTrayViewed = true
	case statusErrorConnection:
		if tray.InternetConnectionTrayViewed {
			return
		}
		message = "Sem conexão com a internet"
		icon = widgets.QSystemTrayIcon__Critical
		tray.InternetConnectionTrayViewed = true
	default:
		return
	}

	tray.TriggerSlot(func() {
		tray.ShowMessage(systemTrayTitle, message, icon, 5000)
	})
}

func (tray *QSystemTrayIconCustomSlot) showUploadStatus(clientStatus clientstatus.Response) {
	var message string
	var icon widgets.QSystemTrayIcon__MessageIcon

	switch clientStatus.Upload.ProcessingStatus {
	case statusProcessing:
		tray.InternetConnectionTrayViewed = false
		tray.UploadCompletedTrayViewed = false
		return
	case statusFinished:
		if tray.UploadCompletedTrayViewed {
			return
		}
		message = "O envio dos documentos terminou"
		icon = widgets.QSystemTrayIcon__Information
		tray.UploadCompletedTrayViewed = true
	case statusErrorConnection:
		if tray.InternetConnectionTrayViewed {
			return
		}
		message = "Sem conexão com a internet"
		icon = widgets.QSystemTrayIcon__Critical
		tray.InternetConnectionTrayViewed = true
	default:
		return
	}

	tray.TriggerSlot(func() {
		tray.ShowMessage(systemTrayTitle, message, icon, 5000)
	})
}
