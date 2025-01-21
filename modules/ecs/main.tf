resource "aws_ecs_cluster" "foo" {
  name = "app-cluster"
}

resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "service-first"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "my-app"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.mongo.arn
  desired_count   = 3
  launch_type = "EC2"
}