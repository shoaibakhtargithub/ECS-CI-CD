resource "aws_ecs_task_definition" "this" {
  family                   = "strapi-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024

  execution_role_arn = aws_iam_role.ecs_execution.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "301782007642.dkr.ecr.eu-north-1.amazonaws.com/shoaib-strapi-image:latest"
      essential = true

      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
      ]

      environment = [
        { name = "DATABASE_CLIENT",     value = "postgres" },
        { name = "DATABASE_HOST",       value = aws_db_instance.strapi_db.address },
        { name = "DATABASE_PORT",       value = "5432" },
        { name = "DATABASE_NAME",       value = var.db_name },
        { name = "DATABASE_USERNAME",   value = var.db_username },
        { name = "DATABASE_PASSWORD",   value = var.db_password },
        { name = "ADMIN_JWT_SECRET",    value = "changeme-super-secret-admin-jwt" },
        { name = "APP_KEYS",            value = "key1,key2,key3" },
        { name = "API_TOKEN_SALT",      value = "change-me-api-salt-123" },
        { name = "TRANSFER_TOKEN_SALT", value = "change-me-transfer-salt-456" },
        { name = "ENCRYPTION_KEY",      value = "change-me-encryption-key-789" }
      ]


    }
  ])
}

