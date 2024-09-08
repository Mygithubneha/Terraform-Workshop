terraform {
  backend "s3" {
    bucket = "terraform-workshop-for-prod-env"
    key    = "tf-workspaces/prod.tfstate"
    region = "ap-south-1"

  }
}
provider "aws" {
  region = var.region

}