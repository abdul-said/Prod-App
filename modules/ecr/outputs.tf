output "registry-uri" {
  value = aws_ecr_repository.production.repository_url
}