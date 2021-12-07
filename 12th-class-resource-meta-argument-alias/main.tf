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
    alias = "east"
  # Configuration options
} 

provider "aws" {
    profile = "default"
    region = "ap-southnorth-1"
    alias = "north"
} 

data "aws_ami" "amazon-linux2" {
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "owner-alias"
      values = ["amazon"]
  }
  filter {
      name = "name"
      values = ["amazn2-ami-hvm*"]
  }
  
}

resource "aws_instance" "east-webserver1" {
 # ami = "ami-0fed77069cd5a6d6c"
  ami = data.aws_ami.amazon-linux2.id
  instance_type = "t2.micro"
  key_name = "singapore"
#USing local varibales 
  tags = {
    Name = "east-webserver-1"
  }
} 

resource "aws_instance" "north-webserver1" {
  ami = data.aws_ami.amazon-linux2.id
  instance_type = "t2.micro"
  key_name = "singapore"
#USing local varibales 
  tags = {
    Name = "north-webserver-1"
  }
} 

#output variables
output "east-instance-public-ip"{
  value = aws_instance.east-webserver1.public_ip
}
output "north-instance-public-ip"{
  value = aws_instance.north-webserver1.public_ip
}

/*
output "instance-DNS-ip"{
  value = aws_instance.webserver1.public_dns
}
*/