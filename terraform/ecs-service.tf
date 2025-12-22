resource "aws_ecs_service" "this" {
  name          = "strapi-service"
  cluster       = aws_ecs_cluster.this.id
  desired_count = 1

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = data.aws_subnets.default_vpc_subnets.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  depends_on = [aws_lb_listener.http]
}
