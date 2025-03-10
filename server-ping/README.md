# Server Ping

This server initiates the communication with the Server Pong.

## Running with Docker

Build the image:

```console
docker build -t server-ping .
```

Run the container:

```console
docker run -p 8081:8081 -t server-ping
```

## Running without Docker

Run the server:

```console
go run .
```

In another terminal send the Ping:

```console
curl http://localhost:8081/ping
```
