terraform {
  backend "s3" {
    bucket = "terraform-workshop-for-dev-env"
    key    = "tf-workspaces/dev.tfstate"
    region = "ap-south-1"

  }
}
provider "aws" {
  region = var.region
}