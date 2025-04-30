output "s3_bucket_name" {
  description = "S3 bucket used to store Jenkins data"
  value       = aws_s3_bucket.jenkins_data.bucket
}