data "template_file" "s3_policy" {
  template = file("./spa/s3_policy.json")

  vars = {
    origin_access_identity = aws_cloudfront_origin_access_identity.this.id
    bucket_name            = local.bucket_name
  }
}

data "aws_route53_zone" "this" {
  name         = var.domain
  private_zone = false
}
