resource "aws_ecs_service" "this" {
  name    = "strapi-service"
  cluster = aws_ecs_cluster.this.id

  desired_count = 1

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  health_check_grace_period_seconds = 120

  network_configuration {
    subnets          = data.aws_subnets.default_vpc_subnets.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi_blue.arn
    container_name   = "strapi"
    container_port   = 1337
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer,
      capacity_provider_strategy
    ]
  }

  depends_on = [aws_lb_listener.http]
}
