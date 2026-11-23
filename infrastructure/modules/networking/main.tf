locals {
  az_indices = {
    for index, zone in var.availability_zones : zone => index
  }

  nat_gateway_zones = var.nat_gateway_mode == "per_az" ? var.availability_zones : var.nat_gateway_mode == "single" ? slice(var.availability_zones, 0, 1) : []

  private_route_table_keys = var.nat_gateway_mode == "per_az" ? var.availability_zones : ["shared"]

  private_nat_routes = var.nat_gateway_mode == "per_az" ? {
    for zone in var.availability_zones : zone => zone
    } : var.nat_gateway_mode == "single" ? {
    shared = var.availability_zones[0]
  } : {}
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-igw"
  })
}

resource "aws_subnet" "public" {
  for_each = local.az_indices

  vpc_id                  = aws_vpc.this.id
  availability_zone       = each.key
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_newbits, each.value * 2)
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-public-${each.key}"
    Tier = "public"
  })
}

resource "aws_subnet" "private" {
  for_each = local.az_indices

  vpc_id                  = aws_vpc.this.id
  availability_zone       = each.key
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_newbits, (each.value * 2) + 1)
  map_public_ip_on_launch = false

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-private-${each.key}"
    Tier = "private"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-public"
  })
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = toset(local.private_route_table_keys)

  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-private-${each.key}"
  })
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = var.nat_gateway_mode == "per_az" ? aws_route_table.private[each.key].id : aws_route_table.private["shared"].id
}

resource "aws_eip" "nat" {
  for_each = toset(local.nat_gateway_zones)

  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-nat-eip-${each.key}"
  })
}

resource "aws_nat_gateway" "this" {
  for_each = toset(local.nat_gateway_zones)

  allocation_id     = aws_eip.nat[each.key].id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public[each.key].id

  depends_on = [aws_internet_gateway.this]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-nat-${each.key}"
  })
}

resource "aws_route" "private_nat" {
  for_each = local.private_nat_routes

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.value].id
}