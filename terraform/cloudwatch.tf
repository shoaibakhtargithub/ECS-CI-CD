resource "aws_cloudwatch_log_group" "strapi" {
  name              = "shoaib-cloudwatch"
  retention_in_days = 7
}
