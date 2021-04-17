variable "s3_bucket_name" {
  default = "go-next-remote-state"
}

resource "aws_s3_bucket" "remote-state" {
  bucket = var.s3_bucket_name

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Terraform = "true"
    Name      = "go-next"
  }
}

resource "aws_dynamodb_table" "state-lock" {
  name         = "go-next-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Terraform = "true"
    Name      = "go-next"
  }
}
