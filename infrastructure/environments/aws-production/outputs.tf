output "vpc_id" {
  description = "ID of the production VPC."
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs keyed by Availability Zone."
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs keyed by Availability Zone."
  value       = module.networking.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs keyed by Availability Zone."
  value       = module.networking.nat_gateway_ids
}

output "eks_cluster_name" {
  description = "EKS cluster name, when EKS creation is enabled."
  value       = length(module.kubernetes) > 0 ? module.kubernetes[0].cluster_name : null
}

output "eks_cluster_endpoint" {
  description = "EKS API endpoint, when EKS creation is enabled."
  value       = length(module.kubernetes) > 0 ? module.kubernetes[0].cluster_endpoint : null
}

output "elearning_efs_id" {
  description = "EFS ID for E-learning moodledata, when storage creation is enabled."
  value       = length(module.elearning_storage) > 0 ? module.elearning_storage[0].efs_id : null
}

output "elearning_backup_bucket_name" {
  description = "Dedicated E-learning backup bucket name, when storage creation is enabled."
  value       = length(module.elearning_storage) > 0 ? module.elearning_storage[0].backup_bucket_name : null
}