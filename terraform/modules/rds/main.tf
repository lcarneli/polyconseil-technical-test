resource "aws_db_subnet_group" "private" {
  name = "${var.customer_name}-${var.project_name}-private"

  subnet_ids = var.subnet_ids

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}-private"
  }
}

resource "aws_security_group" "database" {
  name        = "${var.customer_name}-${var.project_name}-rds"
  description = "The security group for RDS."
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow inbound database communication from EKS cluster."
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.security_groups
  }

  egress {
    description = "Deny all outbound communication from RDS."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}-rds"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "${var.customer_name}-${var.project_name}"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.private.name
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.database.id]

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}"
  }
}