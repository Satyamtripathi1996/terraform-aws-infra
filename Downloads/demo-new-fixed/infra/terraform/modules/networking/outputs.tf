output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "Public subnet IDs"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "Private subnet IDs"
}

output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "ALB security group ID"
}

output "ecs_sg_id" {
  value       = aws_security_group.ecs_sg.id
  description = "ECS security group ID"
}
