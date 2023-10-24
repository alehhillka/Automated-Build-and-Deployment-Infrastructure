resource "aws_lb" "web" {
  name               = "my-web-alb"
  internal           = false  # Якщо true, то LB буде внутрішнім (для ВПЗ), false - публічним
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
}

resource "aws_security_group" "lb_sg" {
  name        = "lb-security-group"
  description = "Security group for ALB"
  vpc_id = module.vpc.vpc_id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

  # Додайте інші налаштування за потребою
}
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project.arn
  }
}