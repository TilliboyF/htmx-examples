package handler

import (
	"net/http"

	"github.com/TilliboyF/htmx-examples/view/loginForm"
)

func HandleGetLogin(w http.ResponseWriter, r *http.Request) error {
	return loginForm.Index().Render(r.Context(), w)
}
