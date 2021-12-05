#output variables
output "instance-public-ip"{
  value = aws_instance.webserver1.public_ip
}

output "instance-DNS-ip"{
  value = aws_instance.webserver1.public_dns
}
