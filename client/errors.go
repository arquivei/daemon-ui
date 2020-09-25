package client

import (
	"github.com/arquivei/foundationkit/errors"
)

var (
	//NoBackendConnectionErrCode is returned when the app cannot connect with backend service
	NoBackendConnectionErrCode = errors.Code("NO_BACKEND_CONN_ERROR")
)
