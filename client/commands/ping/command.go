package ping

import (
	"encoding/json"

	"arquivei.com.br/daemon-ui/client/commands"
)

//Command ...
type Command struct {
	Name commands.CommandName
}

//NewCommand method creates a new command
func NewCommand() commands.CommandInterface {
	return &Command{
		Name: "PING_CMD",
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
