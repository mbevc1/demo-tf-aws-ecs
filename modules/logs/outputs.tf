output logs_group {
  value = "${aws_cloudwatch_log_group.log_group.arn}"
}

output logs_group_name {
  value = "${var.name}-logs"
}
