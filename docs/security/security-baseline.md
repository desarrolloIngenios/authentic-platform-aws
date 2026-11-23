# Baseline de seguridad

- Mínimo privilegio.
- Identidad empresarial para administración.
- RBAC por namespace y función.
- Network Policies con denegación por defecto en servicios sensibles.
- Cifrado de discos y backups.
- TLS para entrada y comunicación sensible.
- Sin secretos en Git.
- Auditoría de acceso y cambios.
- Escaneo de imágenes y SBOM.
- Backups separados y pruebas de restauración.
- Rotación periódica de credenciales.
- PostgreSQL y Redis nunca expuestos a Internet.
