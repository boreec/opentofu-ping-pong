# 🏓 Terraform ping-pong WIP

This project is a custom implementation using **Terraform** and **Minikube**
featuring two REST servers that continuously exchange ping-pong messages every
5 seconds.

## Contents

- **server-ping**: HTTP REST server made with Go that initiates the exchange
  and responds on `/ping`.
- **server-pong**: HTTP REST server made with Rust that responds to ping
  and responds on `/pong`.
