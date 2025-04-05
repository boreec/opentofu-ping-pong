FROM lukemathwalker/cargo-chef:latest-rust-1.85.1-slim-bookworm AS chef
ARG upx_version=5.0.0

RUN apt-get update
RUN apt-get install -y --no-install-recommends curl tar xz-utils
RUN curl -Ls https://github.com/upx/upx/releases/download/v${upx_version}/upx-${upx_version}-amd64_linux.tar.xz -o - | tar xvJf - -C /tmp && \
  cp /tmp/upx-${upx_version}-amd64_linux/upx /usr/local/bin/ && \
  chmod +x /usr/local/bin/upx && \
  apt-get remove -y xz-utils && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

FROM chef AS planner
COPY ./Cargo.toml ./Cargo.lock ./
COPY ./src ./src
RUN cargo chef prepare

FROM chef AS builder
COPY --from=planner /app/recipe.json .
RUN cargo chef cook --release
COPY . .
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo build --release --target x86_64-unknown-linux-musl
RUN upx --best --lzma ./target/x86_64-unknown-linux-musl/release/server-pong
RUN mv ./target/x86_64-unknown-linux-musl/release/server-pong ./app

FROM scratch AS runtime
WORKDIR /app
COPY --from=builder /app/app /usr/local/bin/
EXPOSE 8082
CMD ["/usr/local/bin/app"]
