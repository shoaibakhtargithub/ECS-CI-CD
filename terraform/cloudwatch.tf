resource "aws_cloudwatch_log_group" "strapi" {
  name              = "shoaib-cloudwatch"
  retention_in_days = 7
}

resource "aws_cloudwatch_dashboard" "strapi_dashboard" {
  dashboard_name = "strapi-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x = 0
        y = 0
        width  = 12
        height = 6

        properties = {
          title  = "ECS CPU Utilization"
          region = var.aws_region

          metrics = [
            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName", aws_ecs_cluster.this.name,
              "ServiceName", aws_ecs_service.this.name
            ]
          ]

          period = 300
          stat   = "Average"
        }
      },
      {
        type = "metric"
        x = 12
        y = 0
        width  = 12
        height = 6

        properties = {
          title  = "ECS Memory Utilization"
          region = var.aws_region

          metrics = [
            [
              "AWS/ECS",
              "MemoryUtilization",
              "ClusterName", aws_ecs_cluster.this.name,
              "ServiceName", aws_ecs_service.this.name
            ]
          ]

          period = 300
          stat   = "Average"
        }
      }
    ]
  })
}
resource "aws_cloudwatch_metric_alarm" "strapi_high_cpu" {
  alarm_name          = "strapi-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    ClusterName = aws_ecs_cluster.this.name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_description = "Alarm when ECS CPU exceeds 80%"
}

resource "aws_cloudwatch_metric_alarm" "strapi_high_memory" {
  alarm_name          = "strapi-high-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    ClusterName = aws_ecs_cluster.this.name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_description = "Alarm when ECS Memory exceeds 80%"
}

