 terraform {
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

variable "instance_type" { 
    type = string
}

resource "aws_instance" "webserver1" {
  ami           = "ami-0fed77069cd5a6d6c"
  instance_type = "var.instance_type"
  key_name = "singapore"
  

  tags = {
    Name = "myserver1"
  }
}