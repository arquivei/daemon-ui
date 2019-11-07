package client

import (
	"bufio"
	"log"
	"net"

	"bitbucket.org/arquivei/daemon-ui-poc/client/commands"
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

	log.Println("Command to server: " + data)

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

	log.Println("Message from server: " + resp)

	return []byte(resp), nil
}
