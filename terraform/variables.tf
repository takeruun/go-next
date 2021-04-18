variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}
variable "aws_profile" {
  type        = string
  default     = "default"
  description = "AWS CLI's profile"
}
variable "app_name" {
  type    = string
  default = "go-next"
}

variable "domain" {}
