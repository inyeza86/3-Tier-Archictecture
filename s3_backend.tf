terraform {
  backend "s3" {
    bucket  = "dynamic-webapp-on-aws"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
    profile = "inyeza86"
  }
}
