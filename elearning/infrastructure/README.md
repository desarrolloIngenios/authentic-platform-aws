# Infraestructura AWS de E-learning

Esta ruta documenta y alojará los recursos OpenTofu específicos de E-learning. No duplica los módulos existentes de networking, DNS, security, storage o Kubernetes.

## Recursos previstos

- EKS node pool adicional o configuración dedicada, sujeto a medición.
- EFS para `moodledata` compartido.
- Buckets S3 separados para backups y archivos opcionales.
- AWS Secrets Manager para secretos de la aplicación.
- Identity providers/roles IRSA.
- Security Groups específicos.
- EventBridge/cron externo solo si se evalúa fuera de Kubernetes.
- Route 53 opcional o integración Cloudflare.

## Convenciones

- Reutilizar `infrastructure/modules/networking`.
- Mantener una VPC por ambiente.
- Usar prefijos `authenticfarma360-{environment}-elearning-*`.
- Tags `Environment`, `ManagedBy=OpenTofu` y `Project=AuthenticFarma360`.
- Estado remoto: clave propia por ambiente dentro del bucket existente.
- No ejecutar `apply` hasta aprobación separada del plan.
