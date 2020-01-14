package file

import (
	"io/ioutil"
	"os"
)

//Exists check if the file exists in filsystem
func Exists(filename string) bool {
	info, err := os.Stat(filename)
	if os.IsNotExist(err) {
		return false
	}
	return !info.IsDir()
}

//NewFile creates a new file
func NewFile(content, path string) error {
	if err := ioutil.WriteFile(path, []byte(content), 0644); err != nil {
		return err
	}

	return nil
}

//ReadFile reads an file from filename
func ReadFile(fileName string) ([]byte, error) {
	return ioutil.ReadFile(fileName)
}
