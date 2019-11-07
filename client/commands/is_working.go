package commands

import (
	"encoding/json"
	"errors"
)

type IsWorkingCommand struct {
	Name CommandName
}

type IsWorkingResponse struct {
	Error     string `json:",omitempty"`
	IsWorking bool
}

func NewIsWorkingCommand() CommandInterface {
	return &IsWorkingCommand{
		Name: isWorkingCmd,
	}
}

func (c IsWorkingCommand) Encode() (encoded string, err error) {
	d, err := json.Marshal(c)
	if err != nil {
		return
	}
	encoded = string(json.RawMessage(d))
	return
}

func NewIsWorkingResponse(data []byte) (r IsWorkingResponse, err error) {
	if err := json.Unmarshal(data, &r); err != nil {
		return r, err
	}

	if r.Error != "" {
		return r, errors.New(r.Error)
	}

	return r, nil
}
