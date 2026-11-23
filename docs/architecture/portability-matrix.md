# Matriz de portabilidad

| Capacidad | Preferencia portable | AWS inicial | ¿Dependencia obligatoria? | Alternativa | Estado |
|---|---|---|---|---|---|
| Contenedores | OCI | ECR u registro compatible | No | Harbor / GitHub / GAR | Diseñar |
| Kubernetes | Kubernetes | EKS o EC2 | No | On-premise / otro proveedor | Por ADR |
| Red | CNI + Ingress estándar | AWS VPC CNI / Cilium | No | CNI compatible | Por ADR |
| DNS | Kubernetes DNS / DNS externo | Route 53 | No | Cloudflare / proveedor DNS | Documentar |
| Certificados | cert-manager | Let's Encrypt | No | Otro emisor ACME | Diseñar |
| PostgreSQL | CloudNativePG | CNPG sobre EC2/EBS | No | PostgreSQL operativo | Preferido |
| Redis | Redis compatible | Redis en Kubernetes | No | Managed Redis compatible | Diseñar |
| Objetos | API S3 compatible | S3 | No | MinIO / proveedor compatible | Diseñar |
| Secretos | External Secrets + backend configurable | AWS Secrets Manager opcional | No | Vault / KMS externo | Diseñar |
| Observabilidad | Prometheus / Grafana / Loki | EBS + servicios compatibles | No | Stack portable | Diseñar |
| Balanceador | Kubernetes Service | AWS LB Controller opcional | No | MetalLB / otro LB | Por ADR |
