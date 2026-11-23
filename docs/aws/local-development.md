# Entorno local AWS

## Equipo

- macOS Apple Silicon (`darwin_arm64`).
- AWS CLI `2.41.1`.
- OpenTofu `1.13.9`.
- Homebrew `7.0.14`.

## Acceso

- Autenticación: IAM Identity Center.
- Perfil AWS CLI: `authenticfarma-devops`.
- Permission Set: `AuthenticFarma-Infrastructure-Admin`.
- Región predeterminada: `us-east-1`.
- Cuenta observada para el perfil: `889629667448`; verificar que corresponde al ambiente antes de cada plan.

Iniciar sesión y confirmar la identidad activa:

```sh
aws sso login --profile authenticfarma-devops
aws sts get-caller-identity --profile authenticfarma-devops
```

Los roots de desarrollo, staging y producción usan por defecto el perfil y la región anteriores. Cada uno exige `aws_account_id` explícito y permite sobrescribir `aws_profile` y `aws_region` en un archivo local `*.tfvars`, excluido de Git. No guardar credenciales ni tokens en el repositorio.

Los archivos `.terraform.lock.hcl` de los roots fijan las selecciones del proveedor para despliegues reproducibles. Después de cambiar de Terraform a OpenTofu o de actualizar el proveedor, revisar y validar los cambios del lockfile.