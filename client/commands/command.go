package commands

//CommandName represents the command sent to server
type CommandName string

//CommandInterface contains method to interact with the command
type CommandInterface interface {
	Encode() (string, error)
}
