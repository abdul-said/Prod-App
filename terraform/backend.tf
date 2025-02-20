terraform {
  backend "s3" {
    bucket = "terraform-backend-abdul"
    key    = "production/terraform.tfstate"
    region = "eu-west-2"
  }
}
