output "state_bucket_name" {
  description = "S3 bucket used for OpenTofu state and native state locking."
  value       = aws_s3_bucket.state.bucket
}