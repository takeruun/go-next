resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-sg"
  }
}

resource "aws_security_group_rule" "this" {
  security_group_id = aws_security_group.this.id

  type = "ingress"

  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.alb_security_group_id
}

resource "aws_db_subnet_group" "this" {
  name        = var.db_name
  description = "db subent group of ${var.db_name}"
  subnet_ids  = var.private_subnet_ids
}

resource "aws_db_instance" "this" {
  allocated_storage = 10
  storage_type      = "gp2"
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.db_instance

  identifier          = "${var.app_name}-rds"
  username            = var.db_user
  password            = var.db_password
  skip_final_snapshot = true

  enabled_cloudwatch_logs_exports = [
    "error",
    "general",
    "slowquery"
  ]
  vpc_security_group_ids = [aws_security_group.this.id]
  db_subnet_group_name   = aws_db_subnet_group.this.name
}
