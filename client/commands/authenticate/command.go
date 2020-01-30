package authenticate

import (
	"encoding/json"
	"errors"

	"bitbucket.org/arquivei/daemon-ui-poc/client/commands"
)

//Command ...
type Command struct {
	Name     commands.CommandName
	Email    string
	Password string
}

//Response ...
type Response struct {
	Error   string `json:",omitempty"`
	Success bool
	Message string
}

//NewCommand method creates a new command
func NewCommand(email, password string) commands.CommandInterface {
	return &Command{
		Name:     "AUTHENTICATE_CMD",
		Email:    email,
		Password: password,
	}
}

//Encode method encodes the command
func (c Command) Encode() (encoded string, err error) {
	d, err := json.Marshal(c)
	if err != nil {
		return
	}
	encoded = string(json.RawMessage(d))
	return
}

//Encode method encodes the response
func (r Response) Encode() string {
	json, _ := json.Marshal(r)
	return string(json)
}

//NewResponse create a new response
func NewResponse(data []byte) (r Response, err error) {
	if err := json.Unmarshal(data, &r); err != nil {
		return r, err
	}

	if r.Error != "" {
		return r, errors.New(r.Error)
	}

	return r, nil
}

//NewGenericError creates a generic friendly error
func NewGenericError() Response {
	return Response{
		Message: "Ocorreu um erro desconhecido. Por favor, entre em contato conosco",
		Success: false,
	}
}
