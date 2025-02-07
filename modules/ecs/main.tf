resource "aws_ecs_cluster" "prod_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "prod_task" {
  family = var.task_definition_family
  container_definitions = var.container_definitions
  execution_role_arn = aws_iam_role.task_execution_role.arn
}

resource "aws_ecs_service" "app" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.prod_cluster.id
  task_definition = aws_ecs_task_definition.prod_task.arn
  desired_count   = var.ecs_service_desired_count
  launch_type = var.ecs_service_launch_type
}

resource "aws_iam_role" "task_execution_role" {
  name = var.iam_role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "test-attach2" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = var.iam_role_policy_arn
}