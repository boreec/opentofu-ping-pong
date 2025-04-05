FROM lukemathwalker/cargo-chef:latest-rust-1.85.1-slim-bookworm AS chef
WORKDIR /app

FROM chef AS planner
COPY ./Cargo.toml ./Cargo.lock ./
COPY ./src ./src
RUN cargo chef prepare

FROM chef AS builder
COPY --from=planner /app/recipe.json .
RUN cargo chef cook --release
COPY . .
RUN cargo build --release
RUN mv ./target/release/server-pong ./app

FROM gcr.io/distroless/cc-debian12 AS runtime
WORKDIR /app
COPY --from=builder /app/app /usr/local/bin/
EXPOSE 8082
CMD ["/usr/local/bin/app"]
