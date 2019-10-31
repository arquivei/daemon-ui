package client

import "encoding/json"

type IsWorkingCommand struct {
	Name CommandName
}

func NewIsWorkingCommand() CommandInterface {
	return &IsWorkingCommand{
		Name: isWorkingCmd,
	}
}

func (c IsWorkingCommand) Encode() (string, error) {
	d, err := json.Marshal(c)
	if err != nil {
		return "", err
	}
	return string(json.RawMessage(d)), nil
}
