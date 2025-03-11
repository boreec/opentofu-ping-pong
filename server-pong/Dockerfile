FROM rust:1.85.0 AS builder

WORKDIR /app

COPY . .

RUN cargo build --release

FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/target/release/server-pong .

EXPOSE 8082

CMD ["./server-pong"]
