variable "app_name" {}

variable "vpc_cidr" {
  default = "109.10.0.0/16"
}

variable "azs" {
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "azs_name" {
  default = ["1a", "1c", "1d"]
}

variable "public_subnet_cidrs" {
  default = ["109.10.0.0/24", "109.10.1.0/24", "109.10.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["109.10.10.0/24", "109.10.11.0/24", "109.10.12.0/24"]
}
