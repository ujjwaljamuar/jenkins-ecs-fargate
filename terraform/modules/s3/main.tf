resource "aws_s3_bucket" "jenkins_data" {
  bucket = "jenkins-backup-${random_id.bucket_id.hex}"
  force_destroy = true
}

resource "random_id" "bucket_id" {
  byte_length = 4
}