# Server Pong

This server answers to the Server Ping.

## Running with Docker

Build the image:

```console
docker build -t server-pong .
```

Run the container:

```console
docker run -p 8082:8082 -t server-pong
```

## Running without Docker

Run the server:

```console
cargo run
```

In another terminal send the Pong:

```console
curl http://localhost:8082/pong
```
