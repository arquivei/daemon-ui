package commands

import (
	"encoding/json"
	"errors"
)

type AuthenticateCommand struct {
	Name     CommandName
	Email    string
	Password string
}

type AuthResponse struct {
	Error   string `json:",omitempty"`
	Success bool
	Message string
}

func NewAuthenticateCommand(email, password string) CommandInterface {
	return &AuthenticateCommand{
		Name:     authenticateCmd,
		Email:    email,
		Password: password,
	}
}

func (c AuthenticateCommand) Encode() (encoded string, err error) {
	d, err := json.Marshal(c)
	if err != nil {
		return
	}
	encoded = string(json.RawMessage(d))
	return
}

func (r AuthResponse) Encode() string {
	json, _ := json.Marshal(r)
	return string(json)
}

func NewAuthResponse(data []byte) (r AuthResponse, err error) {
	if err := json.Unmarshal(data, &r); err != nil {
		return r, err
	}

	if r.Error != "" {
		return r, errors.New(r.Error)
	}

	return r, nil
}

func NewAuthResponseError() (r AuthResponse) {
	r.Message = "Ocorreu um erro desconhecido. Por favor, entre em contato conosco"
	r.Success = false
	return
}
