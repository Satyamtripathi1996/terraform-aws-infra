########################################
# ECS Task Execution Role
# - pulls images from ECR
# - writes logs to CloudWatch
# - can read secrets (if provided)
########################################
data "aws_iam_policy_document" "ecs_task_execution_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name               = "${var.app_name}-${var.environment}-ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_execution_managed" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Optional: allow ECS agent to read secrets from Secrets Manager
data "aws_iam_policy_document" "execution_secrets" {
  count = length(var.secrets_arns) > 0 ? 1 : 0

  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = var.secrets_arns
  }
}

resource "aws_iam_role_policy" "execution_secrets" {
  count  = length(var.secrets_arns) > 0 ? 1 : 0
  name   = "${var.app_name}-${var.environment}-execution-secrets"
  role   = aws_iam_role.ecs_task_execution.id
  policy = data.aws_iam_policy_document.execution_secrets[0].json
}

########################################
# ECS Task Role (application permissions)
########################################
resource "aws_iam_role" "ecs_task" {
  name               = "${var.app_name}-${var.environment}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume.json

  tags = var.tags
}

# App S3 permissions (read/write objects)
data "aws_iam_policy_document" "task_s3" {
  count = length(var.s3_bucket_arns) > 0 ? 1 : 0

  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = var.s3_bucket_arns
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [for arn in var.s3_bucket_arns : "${arn}/*"]
  }
}

resource "aws_iam_role_policy" "task_s3" {
  count  = length(var.s3_bucket_arns) > 0 ? 1 : 0
  name   = "${var.app_name}-${var.environment}-task-s3"
  role   = aws_iam_role.ecs_task.id
  policy = data.aws_iam_policy_document.task_s3[0].json
}

# Optional: task can read secrets directly (if app reads secrets itself)
data "aws_iam_policy_document" "task_secrets" {
  count = length(var.secrets_arns) > 0 ? 1 : 0

  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = var.secrets_arns
  }
}

resource "aws_iam_role_policy" "task_secrets" {
  count  = length(var.secrets_arns) > 0 ? 1 : 0
  name   = "${var.app_name}-${var.environment}-task-secrets"
  role   = aws_iam_role.ecs_task.id
  policy = data.aws_iam_policy_document.task_secrets[0].json
}
