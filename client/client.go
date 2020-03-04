package client

import (
	"bufio"
	"net"

	"arquivei.com.br/daemon-ui/client/commands"
)

type Client struct{}

func NewClient() Client {
	return Client{}
}

func (c Client) SendCommand(cmd commands.CommandInterface) (msg []byte, err error) {
	conn, err := net.Dial("tcp", "127.0.0.1:56899")
	if err != nil {
		return msg, err
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
		return msg, err
	}

	// listen for reply
	resp, err := bufio.NewReader(conn).ReadString('\n')
	if err != nil {
		return msg, err
	}

	return []byte(resp), nil
}
