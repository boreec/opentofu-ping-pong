# syntax=docker/dockerfile:1
FROM golang:1.24

# Set destination for COPY
WORKDIR /app

# Download Go modules
COPY go.mod ./
RUN go mod tidy

COPY . .

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /server-ping

EXPOSE 8081

# Run
CMD ["/server-ping"]
