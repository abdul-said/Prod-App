terraform {
  backend "s3" {
    bucket = "terraform-backend-abdul"
    key = "production/terraform.tfstate"
    region = "eu-west-2"
    use_lockfile = true
  }
}
