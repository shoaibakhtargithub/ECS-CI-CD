resource "aws_ecs_service" "this" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default_vpc_subnets.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
  target_group_arn = aws_lb_target_group.strapi_tg.arn
  container_name   = "strapi"
  container_port   = 1337
}

depends_on = [aws_lb_listener.http]

}
