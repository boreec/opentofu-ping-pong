# syntax=docker/dockerfile:1
FROM golang:1.24 AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/server-ping ./main.go

FROM scratch

COPY --from=builder /bin/server-ping /bin/server-ping

EXPOSE 8081

CMD ["/bin/server-ping"]
