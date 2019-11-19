// +build windows

package service

import "syscall"

//Hide command prompt window when using Exec
func getSysProcAttr() *syscall.SysProcAttr {
	return &syscall.SysProcAttr{HideWindow: true}
}
