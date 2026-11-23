variable "name_prefix" {
  description = "Lowercase resource name prefix."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the EFS mount targets."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for EFS mount targets."
  type        = list(string)
}

variable "backup_bucket_name" {
  description = "Globally unique S3 bucket name for E-learning backups."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR allowed to access EFS."
  type        = string
}

variable "tags" {
  description = "Tags applied to storage resources."
  type        = map(string)
  default     = {}
}
