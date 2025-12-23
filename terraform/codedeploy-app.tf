resource "aws_codedeploy_app" "ecs" {
  name             = "strapi-ecs-app-shoaib"
  compute_platform = "ECS"
  
}
