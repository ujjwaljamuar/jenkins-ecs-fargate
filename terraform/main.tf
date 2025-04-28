# Backend configuration (optional, if using remote state like S3)
terraform {
  backend "s3" {
    bucket = "uj-jenkins-terraform-backup"
    key    = "env:/terraform.tfstate"  # Adjust the path as needed
    region = "ap-south-1"  # Ensure this matches the region of your bucket
  }
}
