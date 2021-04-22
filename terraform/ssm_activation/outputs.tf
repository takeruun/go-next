output "ssm_agent_code" {
  value = aws_ssm_activation.this.activation_code
}

output "ssm_agent_id" {
  value = aws_ssm_activation.this.id
}
