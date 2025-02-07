resource "aws_ecr_repository" "production" {
  name = var.ecr_repo_name
}