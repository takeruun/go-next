data "aws_iam_policy" "ssm_managed_instance_core" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "ssm_directory_service_access" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
}

data "aws_iam_policy" "cloud_watch_agent_server_policy" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

data "aws_caller_identity" "user" {}

data "template_file" "update_ssm_service_policy" {
  template = file("ssm_activation/update_ssm_service_policy.json")

  vars = {
    account_id = local.account_id
  }
}
