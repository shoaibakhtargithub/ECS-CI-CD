# Application Load Balancer
resource "aws_lb" "strapi_alb" {
  name               = "strapi-shoaib-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = data.aws_subnets.default_vpc_subnets.ids
}

resource "aws_lb_target_group" "strapi_blue" {
  name        = "strapi-blue-tg"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    path    = "/admin"
    matcher = "200"
  }
}

resource "aws_lb_target_group" "strapi_green" {
  name        = "strapi-green-tg"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    path    = "/admin"
    matcher = "200"
  }
}



# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.strapi_alb.arn
  port              = 80
  protocol          = "HTTP"

default_action {
  type = "fixed-response"

  fixed_response {
    content_type = "text/plain"
    message_body = "Deployment in progress"
    status_code  = "200"
  }
}

}
