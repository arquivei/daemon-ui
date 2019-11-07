package commands

import (
	"encoding/json"
	"errors"
)

type IsAuthenticatedCommand struct {
	Name CommandName
}

type IsAuthenticatedResponse struct {
	Error           string `json:",omitempty"`
	IsAuthenticated bool
}

func NewIsAuthenticatedCommand() CommandInterface {
	return &IsAuthenticatedCommand{
		Name: isAuthenticatedCmd,
	}
}

func (c IsAuthenticatedCommand) Encode() (encoded string, err error) {
	d, err := json.Marshal(c)
	if err != nil {
		return
	}
	encoded = string(json.RawMessage(d))
	return
}

func NewIsAuthenticatedResponse(data []byte) (r IsAuthenticatedResponse, err error) {
	if err := json.Unmarshal(data, &r); err != nil {
		return r, err
	}

	if r.Error != "" {
		return r, errors.New(r.Error)
	}

	return r, nil
}
