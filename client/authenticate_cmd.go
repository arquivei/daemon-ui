package client

import "encoding/json"

type AuthenticateCommand struct {
	Name     CommandName
	Email    string
	Password string
}

func NewAuthenticateCommand(email, password string) CommandInterface {
	return &AuthenticateCommand{
		Name:     authenticateCmd,
		Email:    email,
		Password: password,
	}
}

func (c AuthenticateCommand) Encode() (string, error) {
	d, err := json.Marshal(c)
	if err != nil {
		return "", err
	}
	return string(json.RawMessage(d)), nil
}
