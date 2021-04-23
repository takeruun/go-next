module "ssm_ec2_run_role" {
  source     = "../iam_role"
  name       = "ssm-ec2-run-role"
  identifier = "ssm.amazonaws.com"
  policy_arn = [
    data.aws_iam_policy.ssm_managed_instance_core.arn,
    data.aws_iam_policy.ssm_directory_service_access.arn,
    data.aws_iam_policy.cloud_watch_agent_server_policy.arn,
    aws_iam_policy.update_ssm_service_policy.arn,
  ]
}

locals {
  account_id = data.aws_caller_identity.user.account_id
}

resource "aws_iam_policy" "update_ssm_service_policy" {
  name   = "update-ssm-service"
  policy = data.template_file.update_ssm_service_policy.rendered
}

resource "aws_ssm_activation" "this" {
  name               = "${var.app_name}-ssm"
  iam_role           = module.ssm_ec2_run_role.iam_role_name
  registration_limit = "5"
}
