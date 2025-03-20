terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    helm = {
      source = "opentofu/helm"
      version = "3.0.0-pre2"
    }
    kubernetes = {
      source = "opentofu/kubernetes"
      version = "2.36.0"
    }
  }
  required_version = "~> 1.9.0"
}

provider "docker" {}

provider "helm" {
  debug = true
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
