package main

import (
	"runtime/debug"

	"arquivei.com.br/daemon-ui/impl/logging"
	"arquivei.com.br/daemon-ui/service"
	log "github.com/sirupsen/logrus"
)

var r resources

func main() {
	defer func() {
		if r := recover(); r != nil {
			log.WithField("error", r).
				WithField("stacktrace", string(debug.Stack())).
				Error("Recovered from panic! Closing application.")
		}
	}()

	r.initLogger()

	if err := r.setupClient(); err != nil {
		log.WithError(err).Error("An error occurred while setting the client")
	}

	logging.SetupHooks()

	r.logger.Info("Starting backend service...")

	s := service.NewBackendService(r.appConnection)

	if err := s.Run(); err != nil {
		r.logger.WithError(err).Error("An unknown error occurred while running backend service")
	}

	r.logger.Info("Starting interface...")

	newGuiInterface()

	r.logger.Info("Stopping backend service...")

	if err := s.Kill(); err != nil {
		r.logger.WithError(err).Error("An error occurred to stop the backend service")
	}
}
