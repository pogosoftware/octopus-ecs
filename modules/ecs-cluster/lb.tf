resource "aws_lb" "ecs" {
  name               = "ecs-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_security_groups
  subnets            = var.vpc_subnet_ids

  enable_deletion_protection = false

  tags = merge(
    var.tags, 
    {
      Name = "ecs-lb"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ecs.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_octopus_server.arn
  }
}

resource "aws_lb_target_group" "ecs_octopus_server" {
  name     = "ecs-octopus-octopus-server"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    path    = "/"
    port    = 80
    matcher = "200,303"
  }
}

resource "aws_autoscaling_attachment" "ecs" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  alb_target_group_arn   = aws_lb_target_group.ecs_octopus_server.arn
}