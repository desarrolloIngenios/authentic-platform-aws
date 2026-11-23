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