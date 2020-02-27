// +build windows

package file

//GetURIScheme method returns the file uri based on operational system
func GetURIScheme() string {
	return "file:///"
}
