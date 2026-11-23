variable "name_prefix" {
  description = "Lowercase AWS resource name prefix."
  type        = string
}

variable "cluster_version" {
  description = "Supported EKS Kubernetes version."
  type        = string
  default     = "1.31"
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs used by the cluster and node group."
  type        = list(string)
}

variable "endpoint_public_access" {
  description = "Whether the EKS API public endpoint is enabled."
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Whether the EKS API private endpoint is enabled."
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "CIDRs allowed to reach the public EKS API endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "node_instance_types" {
  description = "EC2 instance types for the general node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired node count."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum node count."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum node count."
  type        = number
  default     = 4
}

variable "node_disk_size" {
  description = "Node root volume size in GiB."
  type        = number
  default     = 50
}

variable "tags" {
  description = "Tags applied to EKS resources."
  type        = map(string)
  default     = {}
}
