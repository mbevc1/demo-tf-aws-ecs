data "aws_region" "current" {}

data "aws_caller_identity" "with" {}

resource "aws_ecs_cluster" "main" {
  name = "${var.name}-cluster"

  tags = {
    managed_by = "terraform"
  }
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name        = "ecsTaskExecutionRole"
  description = "ECS Execution Role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
}
EOF

  tags = {
    managed_by = "terraform"
  }
}

resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = "${aws_iam_role.ecsTaskExecutionRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.fargate_cpu}"
  memory                   = "${var.fargate_memory}"
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
  task_role_arn            = "${aws_iam_role.ecsTaskExecutionRole.arn}" # Change to required

  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/example_task_definitions.html
  #    "command": [
  #      "/bin/sh -c \"echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Welcome EDinburgh DevOps Meetup!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
  #    ],
  #    "entryPoint": [
  #      "sh",
  #      "-c"
  #    ],

  container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${var.app_image}",
    "essential": true,
    "memory": ${var.fargate_memory},
    "name": "${var.name}-container",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port}
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.name}-logs",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "${var.name}-logs"
      }
    }
  }
]
DEFINITION

  tags = {
    managed_by = "terraform"
  }
}

resource "aws_ecs_service" "main" {
  name            = "tf-ecs-service"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.app.arn}"
  desired_count   = "${var.app_count}"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = ["${var.ecs_sg}"]
    subnets         = "${var.private_subnets}"
  }

  load_balancer {
    target_group_arn = "${var.alb_tg}"
    container_name   = "${var.name}-container"
    container_port   = "${var.app_port}"
  }
}
