package main

import (
	"github.com/boreec/opentofu-ping-pong/server-ping/server"
)

func main() {
	s := server.NewServer()
	if err := s.Run(); err != nil {
		panic(err)
	}
}
