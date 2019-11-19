package main

import (
	"os"
	"runtime/debug"

	"bitbucket.org/arquivei/daemon-ui-poc/application"
	"bitbucket.org/arquivei/daemon-ui-poc/client"
	fileLog "bitbucket.org/arquivei/daemon-ui-poc/impl/logging/file"
	"bitbucket.org/arquivei/daemon-ui-poc/service"
	log "github.com/sirupsen/logrus"
)

var appConnection application.Application
var logger *log.Entry

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

	fileHook := fileLog.NewRotateFileHook(fileLog.RotateFileConfig{
		Filename: "logs/ui.log",
		// MaxSize is the maximum size in megabytes of the log file before it gets rotated.
		MaxSize: 50,
		// MaxAge is the maximum number of days to retain old log files based on the
		// timestamp encoded in their filename.  Note that a day is defined as 24
		// hours and may not exactly correspond to calendar days due to daylight
		// savings, leap seconds, etc.
		MaxBackups: 7,
		// MaxBackups is the maximum number of old log files to retain.
		MaxAge:    1,
		Formatter: &log.JSONFormatter{},
	})

	fileHook.SetLevel(log.DebugLevel)
	log.AddHook(fileHook)

	appConnection = application.NewAppConnection(
		client.NewClient(),
	)

	logger.Info("Starting backend service...")

	s := service.NewBackendService(appConnection)

	if err := s.Run(); err != nil {
		logger.WithError(err).Error("An unknown error occured to execute backend service")
	}

	logger.Info("Starting interface...")

	newGuiInterface()

	logger.Info("Stopping backend service...")

	if err := s.Kill(); err != nil {
		logger.WithError(err).Error("An error occured to stop the backend service")
	}
}
