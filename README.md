# AuthenticFarma Platform Infrastructure

Repositorio oficial de infraestructura, plataforma Kubernetes y migración desde DigitalOcean hacia AWS.

## Principios

- Kubernetes como plataforma tecnológica.
- OpenTofu como infraestructura como código.
- AWS como primer proveedor objetivo.
- Arquitectura portable, modular y reproducible.
- Sin cambios en DigitalOcean ni aprovisionamiento AWS hasta aprobación de cada fase.
- GitOps con Argo CD.
- Helm para componentes y aplicaciones.
- Secretos fuera del repositorio.

## Estado inicial

Este repositorio contiene diseño, documentación y estructuras listas para revisión. No crea recursos en AWS ni modifica DigitalOcean.

## Estructura

- `infrastructure/`: módulos OpenTofu y ambientes.
- `kubernetes/`: bootstrap, namespaces, red, almacenamiento y políticas.
- `platform/`: componentes transversales.
- `services/`: Chatwoot, Jitsi y APIs propias.
- `applications/`: configuración de aplicaciones migrables.
- `migration/`: inventario y planes de migración.
- `gitops/`: proyectos y aplicaciones de Argo CD.
- `scripts/`: validación, backup, restauración y migración.
- `docs/`: arquitectura, operación, seguridad y recuperación.

## Fases

0. Auditoría y planificación.
1. Diseño y aprobación de AWS.
2. Bootstrap de Kubernetes.
3. Servicios transversales.
4. Preparación de migraciones.
5. Migración de bases de datos.
6. Migración progresiva de aplicaciones.
7. Cambio gradual de DNS.
8. Retiro controlado de DigitalOcean.

## Flujo seguro

1. Cambios mediante Pull Request.
2. `tofu fmt`, `validate` y pruebas.
3. `tofu plan` aprobado.
4. Aplicación manual en producción.
5. Evidencias, validación y rollback.

Consulte `docs/architecture/overview.md`, `docs/roadmap.md`, `docs/aws/cost-estimate.md` y `docs/migration/inventory.md`.
