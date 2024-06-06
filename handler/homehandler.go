package handler

import (
	"net/http"

	"github.com/TilliboyF/htmx-examples/view/home"
)

func HandleGetHome(w http.ResponseWriter, r *http.Request) error {
	return home.Index().Render(r.Context(), w)
}
