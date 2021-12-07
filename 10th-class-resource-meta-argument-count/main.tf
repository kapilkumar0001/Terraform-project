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
  count = 2
  ami = "ami-0fed77069cd5a6d6c"
  instance_type = "t2.nano"
  key_name = "singapore"
#USing local varibales 
  tags = {
    Name = "myserver-${count.index}"
  }
} 
#output variables
output "instance-public-ip1"{
  value = aws_instance.webserver1[1].public_ip
}
output "instance-public-ip0"{
  value = aws_instance.webserver1[0].public_ip
}

/*output "instance-DNS-ip"{
  value = aws_instance.webserver1.public_dns
}
*/