package client

//Information contains some informations about the client
type Information struct {
	CurrentVersion string
	MacAddress     string
	GUI            struct {
		Filename string
		PID      int
	}
}

//Storage contains mathods to manipulate the client storage
type Storage interface {
	Write(info Information) error
	Read() (info Information, err error)
}
