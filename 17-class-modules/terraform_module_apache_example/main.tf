
data "aws_vpc" "main" {
  id = var.vpc_id 
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
    cidr_blocks      = [var.my_ip_with_cidr]
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
  public_key = var.public_key
}

data "template_file" "user_data"{
    template = file("${abspath(path.module)}/userdata.yaml") 
}

/*data "aws_ami" "amazon-linux2" {
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
*/
resource "aws_instance" "webserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids= [aws_security_group.my-secuity_group1.id]
  user_data = data.template_file.user_data.rendered
  provisioner "local-exec" {
      command = "echo ${self.private_ip} >> private_ip.txt"
  }

 /* provisioner "remote-exec" {
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
*/
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
    Name = "var.server_name "
    }
}

/*output "PUBLIC_IP" {
    value =  aws_instance.webserver.public_ip
    */