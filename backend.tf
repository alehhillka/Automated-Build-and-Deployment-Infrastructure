terraform {
  backend "s3" {
    bucket         = "automatedci"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "automatedci"
  }
}
