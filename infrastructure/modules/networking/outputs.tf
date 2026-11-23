output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "IPv4 CIDR assigned to the VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs keyed by Availability Zone."
  value       = { for zone, subnet in aws_subnet.public : zone => subnet.id }
}

output "private_subnet_ids" {
  description = "Private subnet IDs keyed by Availability Zone."
  value       = { for zone, subnet in aws_subnet.private : zone => subnet.id }
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs keyed by Availability Zone; empty when NAT is disabled."
  value       = { for zone, gateway in aws_nat_gateway.this : zone => gateway.id }
}