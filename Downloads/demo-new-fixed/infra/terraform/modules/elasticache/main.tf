resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.app_name}-${var.environment}-redis-subnets"
  subnet_ids = var.private_subnet_ids

  tags = var.tags
}

resource "aws_security_group" "redis" {
  name        = "${var.app_name}-${var.environment}-redis-sg"
  description = "Allow Redis from ECS tasks only"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Redis from ECS"
    from_port       = 6379
    to_port         = 6379
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

resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = "${var.app_name}-${var.environment}-redis"
  description                = "Redis for ${var.app_name} (${var.environment})"
  engine                     = "redis"
  engine_version             = var.engine_version
  node_type                  = var.node_type
  port                       = 6379
  automatic_failover_enabled = false

  num_cache_clusters = 1
  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = [aws_security_group.redis.id]

  tags = var.tags
}
