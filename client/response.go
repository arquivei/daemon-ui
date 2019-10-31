package client

type AuthResponse struct {
	Error   string `json:",omitempty"`
	Success bool
	Message string
}

type IsAuthenticatedResponse struct {
	Error           string `json:",omitempty"`
	IsAuthenticated bool
}

type GetUploadFolderResponse struct {
	Error        string `json:",omitempty"`
	UploadFolder string
}

type SetUploadFolderResponse struct {
	Error string `json:",omitempty"`
}

type IsWorkingResponse struct {
	Error     string `json:",omitempty"`
	IsWorking bool
}

func (r AuthResponse) ErrorResponse() AuthResponse {
	r.Message = "Ocorreu um erro desconhecido. Por favor, entre em contato conosco"
	r.Success = false
	return r
}
