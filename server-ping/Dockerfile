FROM golang:1.24 AS builder
ARG upx_version=5.0.0

RUN apt-get update && apt-get install -y --no-install-recommends xz-utils && \
  curl -Ls https://github.com/upx/upx/releases/download/v${upx_version}/upx-${upx_version}-amd64_linux.tar.xz -o - | tar xvJf - -C /tmp && \
  cp /tmp/upx-${upx_version}-amd64_linux/upx /usr/local/bin/ && \
  chmod +x /usr/local/bin/upx && \
  apt-get remove -y xz-utils && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -gcflags=all="-l -B -wb=false" -ldflags="-w -s" -o /bin/server-ping
RUN upx --best --lzma /bin/server-ping

FROM scratch AS runtime
COPY --from=builder /bin/server-ping /bin/server-ping
EXPOSE 8081
CMD ["/bin/server-ping"]
