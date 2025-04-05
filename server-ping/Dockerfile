# syntax=docker/dockerfile:1
FROM golang:1.24 AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/server-ping ./main.go

FROM gcr.io/distroless/static-debian12
COPY --from=builder /bin/server-ping /bin/server-ping
EXPOSE 8081
CMD ["/bin/server-ping"]
