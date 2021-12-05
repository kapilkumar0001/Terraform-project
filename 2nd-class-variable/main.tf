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
#output variables
output "instance-public-ip"{
  value = aws_instance.webserver1.public_ip
}

output "instance-DNS-ip"{
  value = aws_instance.webserver1.public_dns
}
