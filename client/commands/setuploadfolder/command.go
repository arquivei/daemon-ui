package setuploadfolder

import (
	"encoding/json"

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
	Code    string
	Success bool
}

//NewCommand method creates a new command
func NewCommand(path string) commands.CommandInterface {
	return &Command{
		Name: "SET_UPLOAD_FOLDER_CMD",
		Path: path,
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

//NewResponse method creates a new response
func NewResponse(data []byte) (r Response, err error) {
	if err := json.Unmarshal(data, &r); err != nil {
		return r, err
	}

	if r.Error == nil {
		r.Code = "NO_ERROR"
		return r, nil
	}

	r.Code = *r.Error
	return r, nil
}

//NewGenericError creates a generic error
func NewGenericError() Response {
	return Response{
		Code:    "UNKNOWN_SERVER_ERROR",
		Success: false,
	}
}
