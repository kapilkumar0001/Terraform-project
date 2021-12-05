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

#Define local variable

locals {
  project_name = "DIS"
}

resource "aws_instance" "webserver1" {
  ami = "ami-0fed77069cd5a6d6c"
# instance_type = "t2.nano"
  instance_type = var.instance_type
  key_name = "singapore"
  
#USing local varibales 
  tags = {
    Name = "myserver1-${local.project_name}"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

#output variables
output "instance-public-ip"{
  value = aws_instance.webserver1.public_ip
}

output "instance-DNS-ip"{
  value = aws_instance.webserver1.public_dns
}
