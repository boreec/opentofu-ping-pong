terraform {
  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.4.4"
    }
  }
  required_version = "~> 1.9.0"
}

provider "minikube" {
  # Configuration options
}
