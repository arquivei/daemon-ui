package clientinfo

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
	Error               string `json:",omitempty"`
	ClientWebDetailLink string
	ClientHostname      string
	UploadFolders       []string
	DownloadFolder      string
	UserEmail           string
	IsAuthenticated     bool
	LogsPath            string
	IsMainTourViewed    bool
	IsConfigTourViewed  bool
	CanDownload         bool
}

//NewCommand method creates a new command
func NewCommand() commands.CommandInterface {
	return &Command{
		Name: "GET_CLIENT_INFO_CMD",
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
