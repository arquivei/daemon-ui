package logout

import (
	"encoding/json"
	"errors"

	"bitbucket.org/arquivei/daemon-ui-poc/client/commands"
)

//Command ...
type Command struct {
	Name commands.CommandName
	Path string
}

//Response ...
type Response struct {
	Error   *string `json:",omitempty"`
	Success bool
}

//NewCommand method creates a new command
func NewCommand() commands.CommandInterface {
	return &Command{Name: "LOGOUT_CMD"}
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

//NewResponse method creates a new response
func NewResponse(data []byte) (r Response, err error) {
	if err := json.Unmarshal(data, &r); err != nil {
		return r, err
	}

	if r.Error != nil {
		return r, errors.New(*r.Error)
	}

	return
}

//NewGenericError creates a generic error
func NewGenericError() Response {
	return Response{Success: false}
}