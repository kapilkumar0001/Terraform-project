terraform {
  
}

provider "aws" {
    profile = "default"
    region = "ap-southeast-1"
  # Configuration options
} 

module "apache" {
  source = ".//terraform_module_apache_example"

}

output "public_ip" {
  value =  "module.apache.public_ip"
}