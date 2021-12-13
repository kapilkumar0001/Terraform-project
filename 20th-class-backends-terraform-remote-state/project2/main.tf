terraform {
  
}
provider "aws" {
    region = "us-east-1"
}
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../project1/terraform.tfstate"
   }
}
 resource "aws_instance" "webserver" {
  ami           = var.ami_id
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  instance_type = var.instance_type
  #key_name = "${aws_key_pair.deployer.key_name}"
  #vpc_security_group_ids= [aws_security_group.my-secuity_group1.id]
  #user_data = data.template_file.user_data.rendered
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
 /* provisioner "file" {
      content = "mars"
      destination = "/home/ubuntu/ami_name.txt"
      connection {
          type = "ssh"
          user = "ubuntu"
          host = "${self.public_ip}"
          private_key = "${file("/home/kapil/.ssh/id_rsa")}"

      }
    }

*/
  tags = {
    Name = "var.server_name "
    }
}

output "PUBLIC_IP" {
    value =  aws_instance.webserver.public_ip
}