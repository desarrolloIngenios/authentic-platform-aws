variable "name_prefix" {
  description = "Lowercase prefix used in AWS resource names."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*$", var.name_prefix))
    error_message = "name_prefix must contain lowercase letters, numbers, and hyphens."
  }
}

variable "vpc_cidr" {
  description = "Approved, non-overlapping IPv4 range for the VPC."
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR range."
  }
}

variable "availability_zones" {
  description = "Two or more Availability Zones in the selected region."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2 && length(distinct(var.availability_zones)) == length(var.availability_zones)
    error_message = "Provide at least two unique Availability Zones."
  }
}

variable "nat_gateway_mode" {
  description = "Outbound routing for private subnets: none, single, or per_az."
  type        = string

  validation {
    condition     = contains(["none", "single", "per_az"], var.nat_gateway_mode)
    error_message = "nat_gateway_mode must be none, single, or per_az."
  }
}

variable "subnet_newbits" {
  description = "Additional prefix bits for each public/private subnet carved from the VPC CIDR."
  type        = number
  default     = 4

  validation {
    condition     = var.subnet_newbits > 0 && can(cidrsubnet(var.vpc_cidr, var.subnet_newbits, (2 * length(var.availability_zones)) - 1))
    error_message = "The VPC CIDR and subnet_newbits must provide two subnet ranges per Availability Zone."
  }
}

variable "tags" {
  description = "Tags applied to all resources created by this module."
  type        = map(string)
  default     = {}
}