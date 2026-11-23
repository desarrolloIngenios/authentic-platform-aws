output "efs_id" {
  description = "EFS filesystem ID for Moodle moodledata."
  value       = aws_efs_file_system.moodledata.id
}

output "efs_security_group_id" {
  description = "Security group ID for EFS mount targets."
  value       = aws_security_group.efs.id
}

output "backup_bucket_name" {
  description = "Dedicated S3 backup bucket name."
  value       = aws_s3_bucket.backups.id
}
