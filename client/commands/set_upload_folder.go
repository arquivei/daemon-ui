package commands

import (
	"encoding/json"
	"errors"
)

type SetUploadFolderCommand struct {
	Name CommandName
	Path string
}

type SetUploadFolderResponse struct {
	Error string `json:",omitempty"`
}

func NewSetUploadFolderCommand(path string) CommandInterface {
	return &SetUploadFolderCommand{
		Name: setUploadFolderCmd,
		Path: path,
	}
}

func (c SetUploadFolderCommand) Encode() (encoded string, err error) {
	d, err := json.Marshal(c)
	if err != nil {
		return
	}
	encoded = string(json.RawMessage(d))
	return
}

func NewSetUploadFolderResponse(data []byte) (r SetUploadFolderResponse, err error) {
	if err := json.Unmarshal(data, &r); err != nil {
		return r, err
	}

	if r.Error != "" {
		return r, errors.New(r.Error)
	}

	return r, nil
}
