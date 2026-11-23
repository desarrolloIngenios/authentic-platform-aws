# Pruebas de E-learning

Pruebas mínimas antes de habilitar un despliegue:

- Helm lint y rendering por ambiente.
- Validación de NetworkPolicies.
- Conectividad web, PostgreSQL y Redis.
- Moodle Cron ejecutándose una sola vez por programación.
- Persistencia de archivos entre réplicas mediante EFS.
- Privacidad y separación de los tres tenants IOMAD.
- Acceso por roles y permisos de cada organización.
- Backup y restauración completos.
- Renovación de certificados TLS.
- Verificación de incompatibilidades de Moodle/IOMAD/Edwiser RemUI.
- Prueba de carga de subida y reproducción de cursos.
