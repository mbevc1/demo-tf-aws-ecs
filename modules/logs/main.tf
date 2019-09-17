resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.name}-logs"

  tags = {
    #Environment = "production"
    Application = "${var.name}"
    managed_by  = "terraform"
  }
}
