package client

import "encoding/json"

type SetUploadFolderCommand struct {
	Name CommandName
	Path string
}

func NewSetUploadFolderCommand(path string) CommandInterface {
	return &SetUploadFolderCommand{
		Name: setUploadFolderCmd,
		Path: path,
	}
}

func (c SetUploadFolderCommand) Encode() (string, error) {
	d, err := json.Marshal(c)
	if err != nil {
		return "", err
	}
	return string(json.RawMessage(d)), nil
}
