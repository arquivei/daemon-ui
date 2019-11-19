package commands

import (
	"encoding/json"
)

type PingCommand struct {
	Name CommandName
}

func NewPingCommand() CommandInterface {
	return &PingCommand{
		Name: pingCmd,
	}
}

func (c PingCommand) Encode() (encoded string, err error) {
	d, err := json.Marshal(c)
	if err != nil {
		return
	}
	encoded = string(json.RawMessage(d))
	return
}
