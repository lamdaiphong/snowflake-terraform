terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.40.0"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.27.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~>3.4.2"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "~>0.9.6"
    }
  }

}


