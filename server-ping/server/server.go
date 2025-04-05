package server

import "github.com/valyala/fasthttp"

type Server struct{}

func NewServer() *Server {
	return &Server{}
}

// Run starts the server.
func (s *Server) Run() error {
	mux := func(ctx *fasthttp.RequestCtx) {
		switch string(ctx.Path()) {
		case "/healthz":
			healthz(ctx)
		case "/ping":
			ping(ctx)
		default:
			ctx.SetStatusCode(fasthttp.StatusNotFound)
		}
	}

	return fasthttp.ListenAndServe(":8081", mux)
}

func ping(ctx *fasthttp.RequestCtx) {
	if !ctx.IsGet() {
		return
	}
	ctx.WriteString("ping")
}

func healthz(ctx *fasthttp.RequestCtx) {
	ctx.WriteString("OK")
}
