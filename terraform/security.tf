resource "aws_security_group" "ecs_sg" {
  name        = "strapi-ecs-sg"
  description = "Allow Strapi traffic to ECS tasks"
  vpc_id      = data.aws_vpc.default.id

ingress {
  from_port       = 1337
  to_port         = 1337
  protocol        = "tcp"
  security_groups = [aws_security_group.alb_sg.id]
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "strapi-ecs-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "shoaib-rds-sg"
  description = "Allow DB access from Strapi EC2"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description     = "Postgres from strapi"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]


  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shoaib-rds-sg"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "strapi-alb-sg"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "strapi-alb-sg"
  }
}

