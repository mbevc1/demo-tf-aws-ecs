output lb_sg {
  value = "${aws_security_group.ecs_lb.id}"
}

output ecs_sg {
  value = "${aws_security_group.ecs_tasks.id}"
}
