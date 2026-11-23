# Ambiente AWS production

Este root crea una VPC independiente con subredes públicas y privadas en las zonas configuradas. Usa el módulo común `infrastructure/modules/networking` y el prefijo `authenticfarma360-production`.

El perfil predeterminado es `authenticfarma-devops`, autenticado mediante IAM Identity Center, y la región predeterminada es `us-east-1`. Inicie sesión con `aws sso login --profile authenticfarma-devops`. El perfil actualmente resuelve a la cuenta `889629667448`; no asuma que esta es la cuenta productiva, confirme el ID de producción antes de preparar un plan. Puede sobrescribir `aws_profile` y `aws_region` localmente cuando corresponda.

Defina `aws_account_id` en un archivo `*.tfvars` local. El CIDR predeterminado es `10.30.0.0/16`, según el plan de direccionamiento. Usa estado remoto con clave S3 propia, tres AZ (`us-east-1a/b/c`) y NAT deshabilitado; las subredes privadas no tendrán salida a Internet.

`project_name` usa `AuthenticFarma360` y `environment` está fijado a `production`. No hay backend remoto configurado. Antes de cualquier despliegue, aprobar las ADR pertinentes, diseñar el backend cifrado con bloqueo, configurar identidad AWS de mínimo privilegio y revisar un `plan`. `apply` requiere aprobación separada.
