terraform {
  
}
variable "hello" {
  type = string
}

variable "fruit" {
  type = list
}
#run ths command in terraform console
#[for w in var.fruit : upper(w)] 

variable "games_value" {
  type = map
}