resource "aws_ecr_repository" "production" {
  name = var.ecr_repo_name
  force_delete = true
}
