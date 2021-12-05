 terraform {
    backend "remote" {
       organization = "kapil_kamboj"

       workspaces {
         name = "getting-started"
       }
    }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.68.0"
    }
  }
}

provider "aws" {
    profile = "default"
    region = "ap-southeast-1"
  # Configuration options
} 
