package server

import (
	"errors"
	"io"
	"net"
	"strings"
)

// Server represents the running server.
type Server struct{}

// NewServer creates a new Server instance.
func NewServer() *Server {
	return &Server{}
}

// Run starts the server.
func (s *Server) Run() error {
	listener, err := net.Listen("tcp", ":8081")
	if err != nil {
		return err
	}
	defer listener.Close()

	for {
		conn, err := listener.Accept()
		if err != nil {
			continue
		}
		go handleConnection(conn)
	}
}

func handleConnection(conn net.Conn) {
	defer conn.Close()
	buf := make([]byte, 1024)
	n, err := conn.Read(buf)
	if err != nil {
		if !errors.Is(err, io.EOF) {
			conn.Write([]byte("HTTP/1.1 500 Internal Server Error\r\n\r\n"))
		}
		return
	}

	request := string(buf[:n])
	lines := strings.Split(request, "\r\n")
	if len(lines) == 0 {
		conn.Write([]byte("HTTP/1.1 400 Bad Request\r\n\r\n"))
		return
	}

	if strings.HasPrefix(lines[0], "GET /healthz ") {
		conn.Write([]byte("HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nOK"))
	} else if strings.HasPrefix(lines[0], "GET /ping ") {
		conn.Write([]byte("HTTP/1.1 200 OK\r\nContent-Length: 4\r\n\r\nping"))
	} else {
		conn.Write([]byte("HTTP/1.1 404 Not Found\r\n\r\n"))
	}
}
