# DB subnet group (private subnets only)
resource "aws_db_subnet_group" "this" {
  name       = "${var.app_name}-${var.environment}-db-subnets"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.app_name}-${var.environment}-db-subnets"
  })
}

# Security group for DB: allow 5432 from ECS SG only
resource "aws_security_group" "db" {
  name        = "${var.app_name}-${var.environment}-db-sg"
  description = "Allow Postgres from ECS tasks only"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Postgres from ECS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_sg_id]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_db_instance" "this" {
  identifier = "${var.app_name}-${var.environment}-db"

  engine         = "postgres"
  engine_version = var.engine_version

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]

  publicly_accessible = false
  multi_az            = false

  skip_final_snapshot = var.skip_final_snapshot

  tags = merge(var.tags, {
    Name = "${var.app_name}-${var.environment}-db"
  })
}
