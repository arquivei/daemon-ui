package file

import (
	"io"

	"github.com/sirupsen/logrus"
	"gopkg.in/natefinch/lumberjack.v2"
)

type RotateFileConfig struct {
	Filename   string
	MaxSize    int
	MaxBackups int
	MaxAge     int
	Formatter  logrus.Formatter
}

type RotateFileHook struct {
	Config    RotateFileConfig
	logLevels []logrus.Level
	logWriter io.Writer
}

func NewRotateFileHook(config RotateFileConfig) *RotateFileHook {
	hook := RotateFileHook{
		Config: config,
	}

	hook.logWriter = &lumberjack.Logger{
		Filename:   config.Filename,
		MaxSize:    config.MaxSize,
		MaxBackups: config.MaxBackups,
		MaxAge:     config.MaxAge,
	}

	return &hook
}

// Levels method to implement for the hook interface, telling logrus which levels it needs to call us for
func (hook *RotateFileHook) Levels() []logrus.Level {
	if len(hook.logLevels) == 0 {
		return logrus.AllLevels
	}
	return hook.logLevels
}

// SetLevel method for user to define from which level we want to log
func (hook *RotateFileHook) SetLevel(level logrus.Level) {
	for _, element := range logrus.AllLevels {
		if int32(element) <= int32(level) {
			hook.logLevels = append(hook.logLevels, element)
		}
	}
}

func (hook *RotateFileHook) Fire(entry *logrus.Entry) (err error) {
	b, err := hook.Config.Formatter.Format(entry)
	if err != nil {
		return err
	}
	hook.logWriter.Write(b)
	return nil
}
