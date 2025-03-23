# 🧈🏓 OpenTofu ping-pong WIP

This project is a custom implementation using **Opentofu** and **Minikube**
featuring two REST servers that continuously exchange ping-pong messages every
5 seconds.

- [Requirements](#requirements)
- [Contents](#contents)
- [Usage](#usage)

## Requirements

- [Docker](https://www.docker.com/)
- [Helm](https://helm.sh/)
- [Make](https://www.gnu.org/software/make/)
- [Minikube](https://minikube.sigs.k8s.io/docs/)
- [OpenTofu](https://opentofu.org/)

## Contents

- **server-ping**: HTTP REST server made with Go that initiates the exchange
  and responds on `/ping`.
- **server-pong**: HTTP REST server made with Rust that responds to ping
  and responds on `/pong`.

## Usage

All actions are done through the Makefile. To start the minikube cluster (if
it is not already running), and deploy resources:

```console
make deploy
```

After use, clean up the resources:

```console
make clean
```
