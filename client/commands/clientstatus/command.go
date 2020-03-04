package clientstatus

import (
	"encoding/json"
	"errors"

	"arquivei.com.br/daemon-ui/client/commands"
)

//Command ...
type Command struct {
	Name commands.CommandName
}

//Response ...
type Response struct {
	Error            string `json:",omitempty"`
	ProcessingStatus string
	TotalDocuments   int
	TotalSent        int
	HasDocumentError bool
}

//NewCommand method creates a new command
func NewCommand() commands.CommandInterface {
	return &Command{
		Name: "GET_CLIENT_STATUS_CMD",
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

	if r.Error != "" {
		return r, errors.New(r.Error)
	}

	return r, nil
}

//NewGenericError creates a generic error
func NewGenericError() Response {
	return Response{
		ProcessingStatus: "STATUS_ERROR_UNKNOWN",
	}
}
