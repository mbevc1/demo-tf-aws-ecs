resource "aws_alb" "main" {
  name            = "${var.name}-alb"
  subnets         = "${var.public_subnets}"
  security_groups = ["${var.security_group}"]
}

resource "aws_alb_target_group" "app" {
  name        = "${var.name}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_main_id}"
  target_type = "ip"

  health_check {
    interval = "5"
    timeout  = "2"
  }

  depends_on = [
    "aws_alb.main",
  ]
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.app.id}"
    type             = "forward"
  }
}
