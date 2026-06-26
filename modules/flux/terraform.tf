terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.4"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
  }
}