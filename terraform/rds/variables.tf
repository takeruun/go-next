variable "app_name" {}

variable "db_name" {}

variable "db_user" {}

variable "db_password" {}

variable "vpc_id" {}

variable "alb_security_group_id" {}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0.20"
}

variable "db_instance" {
  type    = string
  default = "db.t2.micro"
}

variable "private_subnet_ids" {}