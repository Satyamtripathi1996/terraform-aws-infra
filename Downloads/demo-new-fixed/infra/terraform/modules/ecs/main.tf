########################################
# ECS Cluster
########################################
resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-${var.environment}-cluster"

  tags = merge(var.tags, {
    Name = "${var.app_name}-${var.environment}-cluster"
  })
}

########################################
# Logs
########################################
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.app_name}-${var.environment}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

########################################
# Task Definition (Fargate)
########################################
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.app_name}-${var.environment}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = var.environment_variables
      secrets     = var.secrets

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = var.tags
}

########################################
# ECS Service (behind ALB target group)
########################################
resource "aws_ecs_service" "this" {
  name            = "${var.app_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count

  capacity_provider_strategy {
    capacity_provider = var.capacity_provider
    weight            = 1
  }

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = []
  tags       = var.tags
}
