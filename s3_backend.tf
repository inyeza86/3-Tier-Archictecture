terraform {
  backend "s3" {
    bucket = "dynamic-webapp-on-aws"
    key    = "dev/dev.tfstate"
    region = "us-east-1"
  }
}
