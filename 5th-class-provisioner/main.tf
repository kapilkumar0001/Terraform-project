terraform {
 /* backend "remote" {
    organization = "kapil_kamboj"

    workspaces {
      name = "provisioner"
    }
  }
  */
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.68.0"
    }
  }
} 

provider "aws" {
  # Configuration options
    region = "ap-southeast-1"
}

data "aws_vpc" "main" {
  id = "vpc-a6f43ec0"
  }

resource "aws_security_group" "my-secuity_group1" {
  name        = "my-secuity_group1"
  description = "my-secuity_group1 traffic"
  vpc_id      =  data.aws_vpc.main.id

  ingress = [{
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false

  }
  ,
  {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
  ]

  egress {
    description      = "Output traffic"  
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  
}


resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCp5kxjjtP62AruljTxW5evhcgcIEAZnzEBTm5Y045Yb7mwxgV8K/nqktyfmiJjmzxZWfgMlq+SzdlvodwIp9Xr1u0CTEoJTOA18CpEmSTNLl4yMGy6YIDnH8WbQink3knLidpYku/iD308xhmhpERR8PuU8YVRMUGr67EQ3VeDrHf8qj/JOseJZVCn8gw1tCvFHXYTuXEdrhAqp6NyWfKPbb0R2PJAD0Wbvcuhf1B3i2b7rbl1DqaBOS/SqQWgvkh3grCPEGgdnjaLosqpKmoRWeRQv4W7GFXF85l/Rp2nnSNJH9K1cv1kKIus6E8YI35x6uhALTN0vMnRIi2dWpYHskQZsNohBhaM6bJ9Tvy4h0eqq+GoVgjCxYQgRU5QRKZtd6y8CqUKmadSAvtbaQBOMVIh/hK3DlKTwppXyyvimoVLMQ5Qy8ZR2e4DPGbr911bnbwUE39dQ1dipr7xg/fLfQl2SNm2z/HhMsXnZXk96bngciORDOmzVrUAvM5JfTk= kapil@redhat-server"
}

data "template_file" "user_data"{
    template = file("./ userdata.yml")
}

resource "aws_instance" "webserver" {
  ami           = "ami-0fed77069cd5a6d6c"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids= [aws_security_group.my-secuity_group1.id]
  user_data = data.template_file.user_data.rendered
  provisioner "local-exec" {
      command = "echo ${self.private_ip} >> private_ip.txt"
  }

  provisioner "remote-exec" {
      inline = [ 
        "echo ${self.private_ip} >> /home/ubuntu/private_ip.txt"
        #echo hello world >> /home/ubuntu/private_ip.txt"
      ]
      connection {
          type = "ssh"
          user = "ubuntu"
          host = "${self.public_ip}"
          private_key = "${file("/home/kapil/.ssh/id_rsa")}"

      }
  
  }

  provisioner "file" {
      content = "mars"
      destination = "/home/ubuntu/ami_name.txt"
      connection {
          type = "ssh"
          user = "ubuntu"
          host = "${self.public_ip}"
          private_key = "${file("/home/kapil/.ssh/id_rsa")}"

      }
    }


  tags = {
    Name = "myserver"
    }
}
output "PUBLIC_IP" {
    value =  aws_instance.webserver.public_ip
}