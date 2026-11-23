variable "aws_account_id" {
  description = "Approved 12-digit AWS account ID for the production environment."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "aws_account_id must be a 12-digit AWS account ID."
  }
}

variable "aws_region" {
  description = "Approved AWS region for the production environment."
  type        = string
  default     = "us-east-1"

  validation {
    condition     = length(trimspace(var.aws_region)) > 0
    error_message = "aws_region must not be empty."
  }
}

variable "aws_profile" {
  description = "AWS CLI profile configured for IAM Identity Center."
  type        = string
  default     = "authenticfarma-devops"
}

variable "project_name" {
  description = "Project base name applied to AWS resources and tags."
  type        = string
  default     = "AuthenticFarma360"

  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9-]*$", var.project_name))
    error_message = "project_name must contain only letters, numbers, and hyphens, and start with a letter or number."
  }
}

variable "environment" {
  description = "Environment identifier applied to AWS resources."
  type        = string
  default     = "production"

  validation {
    condition     = var.environment == "production"
    error_message = "This root configuration is reserved for production."
  }
}

variable "extra_tags" {
  description = "Additional approved tags for AWS resources."
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "Approved, non-overlapping IPv4 range for the production VPC."
  type        = string
  default     = "10.30.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR range."
  }
}

variable "availability_zones" {
  description = "At least two Availability Zones in the approved AWS region."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]

  validation {
    condition     = length(var.availability_zones) >= 2 && length(distinct(var.availability_zones)) == length(var.availability_zones)
    error_message = "Provide at least two unique Availability Zones."
  }
}

variable "nat_gateway_mode" {
  description = "Private subnet egress mode: none, single, or per_az."
  type        = string
  default     = "none"

  validation {
    condition     = contains(["none", "single", "per_az"], var.nat_gateway_mode)
    error_message = "nat_gateway_mode must be none, single, or per_az."
  }
}

variable "subnet_newbits" {
  description = "Additional CIDR prefix bits used to create each subnet."
  type        = number
  default     = 4
}

variable "enable_eks" {
  description = "Create the production EKS cluster and node group. Disabled until explicitly approved."
  type        = bool
  default     = false
}

variable "enable_elearning_storage" {
  description = "Create E-learning EFS and backup storage. Disabled until explicitly approved."
  type        = bool
  default     = false
}

variable "elearning_backup_bucket_name" {
  description = "Globally unique S3 bucket name for E-learning backups."
  type        = string
  default     = "authenticfarma360-production-elearning-backups-889629667448"
}

variable "eks_cluster_version" {
  description = "Supported EKS Kubernetes version."
  type        = string
  default     = "1.31"
}

variable "eks_endpoint_public_access" {
  description = "Enable the public EKS API endpoint."
  type        = bool
  default     = true
}

variable "eks_endpoint_private_access" {
  description = "Enable the private EKS API endpoint."
  type        = bool
  default     = true
}

variable "eks_public_access_cidrs" {
  description = "CIDRs approved to access the public EKS API endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "eks_node_instance_types" {
  description = "EC2 instance types for the general EKS node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_node_desired_size" {
  description = "Desired node count."
  type        = number
  default     = 2
}

variable "eks_node_min_size" {
  description = "Minimum node count."
  type        = number
  default     = 1
}

variable "eks_node_max_size" {
  description = "Maximum node count."
  type        = number
  default     = 4
}

variable "eks_node_disk_size" {
  description = "Node root volume size in GiB."
  type        = number
  default     = 50
}