// +build !windows

package service

//getName method returns the name of the service when the OS is not windows
func getName() string {
	return "backend-service"
}
