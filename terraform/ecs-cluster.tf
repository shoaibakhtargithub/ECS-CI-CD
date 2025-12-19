resource "aws_ecs_cluster" "this" {
  name = "strapi-ecs-shoaib-cluster"

  capacity_providers = [
    "FARGATE_SPOT"
  ]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }
}
