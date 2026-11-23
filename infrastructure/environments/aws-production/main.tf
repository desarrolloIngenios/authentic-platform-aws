locals {
  resource_name_prefix = "${lower(var.project_name)}-${var.environment}"

  common_tags = merge(var.extra_tags, {
    Environment = var.environment
    ManagedBy   = "OpenTofu"
    Project     = var.project_name
  })
}

module "networking" {
  source = "../../modules/networking"

  name_prefix        = local.resource_name_prefix
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  nat_gateway_mode   = var.nat_gateway_mode
  subnet_newbits     = var.subnet_newbits
  tags               = local.common_tags
}

module "kubernetes" {
  count  = var.enable_eks ? 1 : 0
  source = "../../modules/kubernetes"

  name_prefix             = local.resource_name_prefix
  cluster_version         = var.eks_cluster_version
  vpc_id                  = module.networking.vpc_id
  subnet_ids              = values(module.networking.private_subnet_ids)
  endpoint_public_access  = var.eks_endpoint_public_access
  endpoint_private_access = var.eks_endpoint_private_access
  public_access_cidrs     = var.eks_public_access_cidrs
  node_instance_types     = var.eks_node_instance_types
  node_desired_size       = var.eks_node_desired_size
  node_min_size           = var.eks_node_min_size
  node_max_size           = var.eks_node_max_size
  node_disk_size          = var.eks_node_disk_size
  tags                    = local.common_tags
}

module "elearning_storage" {
  count  = var.enable_elearning_storage ? 1 : 0
  source = "../../modules/storage"

  name_prefix        = "${local.resource_name_prefix}-elearning"
  vpc_id             = module.networking.vpc_id
  subnet_ids         = values(module.networking.private_subnet_ids)
  backup_bucket_name = var.elearning_backup_bucket_name
  vpc_cidr           = module.networking.vpc_cidr
  tags               = merge(local.common_tags, { Component = "elearning" })
}