package tour

import (
	"encoding/json"
	"errors"

	"arquivei.com.br/daemon-ui/client/commands"
)

//Command ...
type Command struct {
	Name commands.CommandName
	Type string
}

//Response ...
type Response struct {
	Error *string `json:",omitempty"`
}

//NewCommand method creates a new command
func NewCommand(tourType string) commands.CommandInterface {
	return &Command{
		Name: "UPDATE_TOUR_CMD",
		Type: tourType,
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

//NewResponse method creates a new response
func NewResponse(data []byte) (r Response, err error) {
	if err := json.Unmarshal(data, &r); err != nil {
		return r, err
	}

	if r.Error != nil {
		return r, errors.New(*r.Error)
	}

	return r, nil
}
