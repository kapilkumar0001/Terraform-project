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


resource "aws_instance" "webserver1" {
  for_each = {
    nano = "t2.nano"
    micro = "t2.micro"
    small = "t2.small"
  }
  ami = "ami-0fed77069cd5a6d6c"
  instance_type = each.value
  key_name = "singapore"
#USing local varibales 
  tags = {
    Name = "myserver-${each.key}"
  }
} 
#output variables
output "instance-public-ip"{
  value = values(aws_instance.webserver1)[*].public_ip
}

/*
output "instance-DNS-ip"{
  value = aws_instance.webserver1.public_dns
}
*/