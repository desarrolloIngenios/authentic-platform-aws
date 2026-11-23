variable "aws_account_id" {
  description = "Approved 12-digit AWS account ID for shared services."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "aws_account_id must be a 12-digit AWS account ID."
  }
}

variable "aws_region" {
  description = "Approved AWS region for shared services."
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
  description = "Environment identifier applied to shared-services resources."
  type        = string
  default     = "shared-services"

  validation {
    condition     = var.environment == "shared-services"
    error_message = "This root configuration is reserved for shared services."
  }
}

variable "extra_tags" {
  description = "Additional approved tags for AWS resources."
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "Approved, non-overlapping IPv4 range for the shared-services VPC."
  type        = string
  default     = "10.40.0.0/16"

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