# Plataforma E-learning Multi-Tenant

Arquitectura preparada para desplegar Moodle/IOMAD en AWS mediante Kubernetes/EKS.

## Alcance inicial

- Tres organizaciones: AuthenticFarma Academy, Authentic Mentors Academy y YoSoy Academy.
- Moodle Community con IOMAD como capa de multi-tenancy.
- Edwiser RemUI sujeto a verificación de licencia y compatibilidad de versiones.
- PostgreSQL independiente para E-learning.
- Redis independiente para caché y sesiones.
- Amazon EFS para `moodledata` compartido por réplicas web.
- Amazon S3 para respaldos y, únicamente si se verifica soporte, almacenamiento de objetos Moodle.

## Arquitectura objetivo

- Amazon EKS.
- Namespace Kubernetes `elearning`.
- Deployment web Moodle.
- Deployment/cronjob separado para Moodle Cron.
- AWS Load Balancer Controller.
- Certificados mediante cert-manager.
- External Secrets Operator con AWS Secrets Manager como backend.
- CloudNativePG para la primera operación portable, con RDS PostgreSQL documentado como alternativa aprobable.
- Redis dedicado dentro de Kubernetes o ElastiCache administrado después de evaluar carga.
- Argo CD para despliegue GitOps.

## Convenciones

- OpenTofu para infraestructura AWS.
- Región inicial: `us-east-1`.
- Proyecto: `AuthenticFarma360`.
- Estado remoto por ambiente en el backend S3 existente.
- Prefijos: `authenticfarma360-{environment}-elearning`.
- Separación de credenciales, base de datos, Redis, IAM, almacenamiento y respaldos.
- Ningún secreto se almacenará en Git.

## Estado

Esta estructura es una base revisable. No contiene valores secretos ni ejecuta cambios. Los recursos AWS requieren aprobación y revisión de `plan` antes de `apply`.
