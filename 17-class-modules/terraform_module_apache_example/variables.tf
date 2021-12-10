variable "vpc_id" {
  type = string
  default = "vpc-a6f43ec0"
}
variable "ami_id" {
  type = string
  default = "ami-0fed77069cd5a6d6c"
}

variable "my_ip_with_cidr" {
  type = string
  default = "106.196.74.20/32"
  description = "provide your ip 106.196.74.20/32 "
}
variable "public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCp5kxjjtP62AruljTxW5evhcgcIEAZnzEBTm5Y045Yb7mwxgV8K/nqktyfmiJjmzxZWfgMlq+SzdlvodwIp9Xr1u0CTEoJTOA18CpEmSTNLl4yMGy6YIDnH8WbQink3knLidpYku/iD308xhmhpERR8PuU8YVRMUGr67EQ3VeDrHf8qj/JOseJZVCn8gw1tCvFHXYTuXEdrhAqp6NyWfKPbb0R2PJAD0Wbvcuhf1B3i2b7rbl1DqaBOS/SqQWgvkh3grCPEGgdnjaLosqpKmoRWeRQv4W7GFXF85l/Rp2nnSNJH9K1cv1kKIus6E8YI35x6uhALTN0vMnRIi2dWpYHskQZsNohBhaM6bJ9Tvy4h0eqq+GoVgjCxYQgRU5QRKZtd6y8CqUKmadSAvtbaQBOMVIh/hK3DlKTwppXyyvimoVLMQ5Qy8ZR2e4DPGbr911bnbwUE39dQ1dipr7xg/fLfQl2SNm2z/HhMsXnZXk96bngciORDOmzVrUAvM5JfTk= kapil@redhat-server"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "server_name" {
  type = string
  default = "Apache Server"
}