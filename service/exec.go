package service

import (
	"os"
	"os/exec"
	"time"

	"bitbucket.org/arquivei/daemon-ui-poc/application"
)

const maxTries = 30

//Service ...
type Service struct {
	app     application.Application
	process *os.Process
}

//NewBackendService creates a new service to communicate with the app backend
func NewBackendService(appConnection application.Application) *Service {
	return &Service{
		app: appConnection,
	}
}

// Run backend service
func (s *Service) Run() error {
	path := getName()

	c := &exec.Cmd{
		Path:        path,
		Args:        append([]string{path}),
		SysProcAttr: getSysProcAttr(),
	}

	if err := c.Start(); err != nil {
		return err
	}

	var totalTries int

	for range time.NewTicker(time.Millisecond * 100).C {
		totalTries++

		err := s.app.Ping()
		if err == nil {
			break
		}
		if totalTries > maxTries {
			return err
		}
	}

	s.process = c.Process

	return nil
}

//Kill backend service
func (s *Service) Kill() error {
	if s.process != nil {
		return s.process.Kill()
	}
	return nil
}
