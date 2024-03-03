terraform {
  backend "s3" {
    bucket  = "polyconseil-terraform"
    key     = "polyconseil-demo"
    region  = "eu-west-3"
    encrypt = true
  }
}