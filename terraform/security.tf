resource "aws_security_group" "ecs_sg" {
  name        = "strapi-ecs-sg"
  description = "Allow Strapi traffic to ECS tasks"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Strapi HTTP"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # OK for now (demo)
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
  name        = "shoaib-rds-sg"   # UPDATED
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
