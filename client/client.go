package client

import (
	"bufio"
	"net"

	"arquivei.com.br/daemon-ui/client/commands"
	"github.com/arquivei/foundationkit/errors"
)

//Client ...
type Client struct{}

//NewClient ...
func NewClient() Client {
	return Client{}
}

//SendCommand ...
func (c Client) SendCommand(cmd commands.CommandInterface) (msg []byte, err error) {
	conn, err := net.Dial("tcp", "127.0.0.1:56899")
	if err != nil {
		return msg, errors.E(err, NoBackendConnectionErrCode)
	}

	defer func() {
		conn.Close()
	}()

	data, err := cmd.Encode()
	if err != nil {
		return msg, err
	}

	// sending message
	_, err = conn.Write([]byte(data + "\r\n"))
	if err != nil {
		return msg, errors.E(err, NoBackendConnectionErrCode)
	}

	// listen for reply
	resp, err := bufio.NewReader(conn).ReadString('\n')
	if err != nil {
		return msg, errors.E(err, NoBackendConnectionErrCode)
	}

	return []byte(resp), nil
}
