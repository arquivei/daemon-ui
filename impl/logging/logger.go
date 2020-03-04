package logging

import (
	fileLog "arquivei.com.br/daemon-ui/impl/logging/file"
	log "github.com/sirupsen/logrus"
)

//SetupHooks method add hooks to logger
func SetupHooks() {
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
}
