package commands

import (
	"encoding/json"
	"errors"
)

type GetUploadFolderCommand struct {
	Name CommandName
}

type GetUploadFolderResponse struct {
	Error        string `json:",omitempty"`
	UploadFolder string
}

func NewGetUploadFolderCommand() CommandInterface {
	return &GetUploadFolderCommand{
		Name: getUploadFolderCmd,
	}
}

func (c GetUploadFolderCommand) Encode() (encoded string, err error) {
	d, err := json.Marshal(c)
	if err != nil {
		return
	}
	encoded = string(json.RawMessage(d))
	return
}

func NewGetUploadFolderResponse(data []byte) (r GetUploadFolderResponse, err error) {
	if err := json.Unmarshal(data, &r); err != nil {
		return r, err
	}

	if r.Error != "" {
		return r, errors.New(r.Error)
	}

	return r, nil
}
