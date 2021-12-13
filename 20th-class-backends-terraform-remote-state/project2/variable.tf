
variable "ami_id" {
  type = string
}

variable "my_ip_with_cidr" {
  type = string
  description = "provide your ip 106.196.74.20/32 "
}
variable "public_key" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "server_name" {
  type = string
}
  