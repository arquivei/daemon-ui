package main

import (
	"os"
	"path/filepath"

	"bitbucket.org/arquivei/daemon-ui-poc/application"
	"bitbucket.org/arquivei/daemon-ui-poc/client"
	clientStorageImpl "bitbucket.org/arquivei/daemon-ui-poc/impl/storage/client"
	log "github.com/sirupsen/logrus"
)

type resources struct {
	appConnection application.App
	logger        *log.Entry
	macAddress    string
	version       string
}

func (r *resources) initLogger() {
	hostname, _ := os.Hostname()
	r.logger = log.WithFields(log.Fields{
		"hostname": hostname,
		"mac":      r.macAddress,
		"version":  r.version,
	})
	log.SetLevel(log.DebugLevel)
}

func (r *resources) setupClient() error {
	r.appConnection = application.NewAppConnection(
		client.NewClient(),
	)
	
	clientStorage := clientStorageImpl.NewJSONFileDatabase()
	clientInfo, err := clientStorage.Read()
	if err != nil {
		return err
	}

	clientInfo.GUI.PID = os.Getpid()
	clientInfo.GUI.Filename = filepath.Base(os.Args[0])

	if err := clientStorage.Write(clientInfo); err != nil {
		return err
	}

	r.version = clientInfo.CurrentVersion

	return nil
}
