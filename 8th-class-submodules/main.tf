 terraform {
  
}
module "aws-server"{
    source = "./aws-server"
    instance_type = "t2.micro"

}

#output variables
output "instance-public-ip"{
  value = "module.aws-server.public_ip"
}
/*
output "instance-DNS-ip"{
  value = module.aws_instance.webserver1.public_dns
}
*/