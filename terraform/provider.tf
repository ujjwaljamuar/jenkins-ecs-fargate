# terraform/provider.tf

provider "aws" {
  region = "ap-south-1"  # Specify your AWS region
}

# Backend configuration (optional, if using remote state like S3)
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "path/to/my/terraform.tfstate"
    region = "ap-south-1"
  }
}
