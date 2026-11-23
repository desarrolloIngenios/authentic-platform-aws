# Backups de E-learning

## Alcance obligatorio

- PostgreSQL: backup consistente y independiente por ambiente.
- `moodledata`: snapshot o copia consistente independiente.
- Configuración IOMAD y Moodle: exportación versionada sin secretos.
- Certificados y claves: gestionados mediante el sistema de secretos externo.
- Restore periódico validado en staging.

## Reglas

- Los backups se almacenan en un bucket S3 dedicado.
- El bucket debe tener cifrado, bloqueo público y control de retención.
- Cada ambiente usa credenciales separadas.
- No se ejecutan restauraciones sobre producción sin aprobación y ventana operativa.
- Las pruebas de restauración no deben contener datos clínicos de YoSoy.
