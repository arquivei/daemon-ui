package client

import (
	"encoding/json"
	"fmt"

	"bitbucket.org/arquivei/daemon-ui-poc/client"
	"bitbucket.org/arquivei/daemon-ui-poc/impl/file"
)

type dbClient struct {
	dbName string
}

//NewJSONFileDatabase creates a new client.Storage
func NewJSONFileDatabase() client.Storage {
	return &dbClient{
		dbName: "client.bin",
	}
}

//Write client information in json file
func (c dbClient) Write(info client.Information) error {
	b, err := json.Marshal(info)
	if err != nil {
		return err
	}

	if err := file.NewFile(string(b), c.dbName); err != nil {
		return err
	}

	return nil
}

//Write client information from json file
func (c dbClient) Read() (info client.Information, err error) {
	if !file.Exists(c.dbName) {
		err = fmt.Errorf("Client database [%s] not found", c.dbName)
		return
	}

	b, err := file.ReadFile(c.dbName)
	if err != nil {
		return
	}

	if err = json.Unmarshal(b, &info); err != nil {
		return
	}

	return info, nil
}
