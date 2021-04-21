variable "aws_region" {
  default = "ap-northeast-1"
}

variable "aws_profile" {
  # type = string
  default     = "default"
  description = "AWS CLI's profile"
}
