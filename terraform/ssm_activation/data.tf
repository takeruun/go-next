data "aws_iam_policy" "ssm_managed_instance_core" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "ssm_directory_service_access" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
}
