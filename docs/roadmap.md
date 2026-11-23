# Roadmap de implementación

## Fase 0 - Auditoría
- Inventariar Kubernetes, repositorios, imágenes, PVC y bases de datos.
- Medir consumo real.
- Crear roadmap por criticidad.
- No modificar DigitalOcean.

## Fase 1 - Diseño AWS
- Comparar EKS y Kubernetes sobre EC2.
- Aprobar ADR.
- Diseñar VPC, subredes, seguridad y costos.
- Sin aprovisionar.

## Fase 2 - Aprovisionamiento aprobado
- Crear infraestructura AWS.
- Crear clúster y node pools.
- Configurar acceso administrativo.

## Fase 3 - Bootstrap
- Instalar componentes base mediante Helm/GitOps.
- Crear namespaces y políticas.
- Validar red, TLS, persistencia y observabilidad.

## Fase 4 - Servicios transversales
- Chatwoot independiente.
- Jitsi independiente.
- APIs propias.

## Fase 5 - Preparación de migración
- Inventario completo y fichas por aplicación.
- Helm Charts y validaciones.
- Planes de DB, archivos, DNS y rollback.

## Fase 6 - Migración
- Migraciones individuales.
- Sin corte simultáneo de bases.
- Aceptación antes de continuar.

## Fase 7 - DNS
- TTL reducido cuando corresponda.
- Cambio gradual.
- Monitoreo y rollback.

## Fase 8 - Retiro
- Solo con aprobación formal.
- Validación final y backups externos.
