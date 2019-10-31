package client

import "encoding/json"

type GetUploadFolderCommand struct {
	Name CommandName
}

func NewGetUploadFolderCommand() CommandInterface {
	return &GetUploadFolderCommand{
		Name: getUploadFolderCmd,
	}
}

func (c GetUploadFolderCommand) Encode() (string, error) {
	d, err := json.Marshal(c)
	if err != nil {
		return "", err
	}
	return string(json.RawMessage(d)), nil
}
