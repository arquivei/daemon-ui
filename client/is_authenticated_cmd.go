package client

import "encoding/json"

type IsAuthenticatedCommand struct {
	Name CommandName
}

func NewIsAuthenticatedCommand() CommandInterface {
	return &IsAuthenticatedCommand{
		Name: isAuthenticatedCmd,
	}
}

func (c IsAuthenticatedCommand) Encode() (string, error) {
	d, err := json.Marshal(c)
	if err != nil {
		return "", err
	}
	return string(json.RawMessage(d)), nil
}
