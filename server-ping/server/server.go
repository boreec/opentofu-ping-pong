package server

import (
	"fmt"
	"net/http"
)

// Represents the running Server.
type Server struct{}

// Creates a new Server instance.
func NewServer() *Server {
	return &Server{}
}

// Runs the Server.
func (s *Server) Run() error {
	http.HandleFunc("/healthz", healthz)
	http.HandleFunc("/ping", ping)

	err := http.ListenAndServe(":8081", nil)
	if err != nil {
		return fmt.Errorf("serving http routes: %w", err)
	}

	return nil
}

func ping(w http.ResponseWriter, req *http.Request) {
	if req.Method != http.MethodGet {
		// only react on GET methods
		return
	}
	fmt.Fprintln(w, "ping")
}

func healthz(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintln(w, "OK")
}
