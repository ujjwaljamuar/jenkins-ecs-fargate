resource "aws_s3_bucket" "jenkins_home" {
  bucket = local.s3_bucket_name

  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.jenkins_home.id

  versioning_configuration {
    status = "Suspended"
  }
}
