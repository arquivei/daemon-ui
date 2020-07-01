// +build !windows

package file

//GetURIScheme method returns the file uri based on operational system
func GetURIScheme() string {
	return "file://"
}

//GetAvailableSchemes method returns all avaiable uri schemes based on operational system
func GetAvailableSchemes() []string {
	return []string{"file://"}
}
